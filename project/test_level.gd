extends Node2D


var _tween : Tween
var _previous_pos : Vector2

var _dropped := false

## Effectively a constant but calculated from the physics settings
var _pixels_per_meter :float = ProjectSettings.get_setting("physics/2d/default_gravity") / 9.8

## Effectively a constant, computed in ready.
var _camera_min_x : int

@onready var _man :Node2D = $Man
@onready var _package :RigidBody2D = $Package
@onready var _camera := $Camera2D

func _ready():
	_camera_min_x = get_viewport().size.x / 2
	
	_tween = create_tween()
	_tween.tween_property(_package, "position", _package.position+Vector2(30,0), 1.0).set_trans(Tween.TRANS_CUBIC)
	_tween.tween_property(_package, "position", _package.position-Vector2(30,0), 1.0).set_trans(Tween.TRANS_CUBIC)	
	_tween.set_ease(Tween.EASE_IN_OUT)
	_tween.set_loops()


func _physics_process(delta:float):
	if _dropped:
		_camera.global_position.x = max(_camera_min_x, _package.global_position.x)
	
	if Input.is_action_just_pressed("drop"):
		_dropped = true
		_tween.stop()
		_package.freeze = false
		
		# Apply impulse in the direction the package is moving from the tween.
		var speed := _package.global_position - _previous_pos
		var momentum := speed * (_package.mass as float) / delta
		_package.apply_impulse(momentum)
		
		# Watch for the package to come to rest
		_package.sleeping_state_changed.connect(_on_package_sleeping_state_changed)

	# Track position so that momentum can be computed
	_previous_pos = _package.global_position


func _on_package_sleeping_state_changed()->void:
	if _package.sleeping:
		var pixel_distance := _package.global_position.x - _man.global_position.x
		var meters := pixel_distance / _pixels_per_meter
		%ScoreLabel.text = "Distance:\n%.2fm" % meters
		
		%ScoreFeedbackLayer.visible=true
		
		_package.sleeping_state_changed.disconnect(_on_package_sleeping_state_changed)


func _on_play_again_button_pressed():
	get_tree().change_scene_to_file("res://test_level.tscn")
