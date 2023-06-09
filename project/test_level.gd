extends Node2D

## This cannot be based on the "viewport" since in HTML5, it might be a weird size.
const _CAMERA_MIN_X := 350 # 700/2

var _tween : Tween
var _previous_pos : Vector2

var _dropped := false

## Effectively a constant but calculated from the physics settings
var _pixels_per_meter :float = ProjectSettings.get_setting("physics/2d/default_gravity") / 9.8

## A record of what happened this game
var _record := GameRecord.new()

@onready var _man :Node2D = $Man
@onready var _package :RigidBody2D = $Package
@onready var _camera := $Camera2D

func _ready():
	_tween = create_tween()
	_tween.tween_property(_package, "position", _package.position+Vector2(30,0), 1.0).set_trans(Tween.TRANS_CUBIC)
	_tween.tween_property(_package, "position", _package.position-Vector2(30,0), 1.0).set_trans(Tween.TRANS_CUBIC)	
	_tween.set_ease(Tween.EASE_IN_OUT)
	_tween.set_loops()
	
	_package.hit.connect(_on_package_hit)


func _physics_process(_delta:float):
	if _dropped:
		_camera.global_position.x = max(_CAMERA_MIN_X, _package.global_position.x)
	
	if not _dropped and Input.is_action_just_pressed("drop"):
		_drop_package()

	# Track position so that momentum can be computed
	_previous_pos = _package.global_position


func _drop_package():
	%DropButton.disabled = true
	_dropped = true
	_tween.stop()
	_package.freeze = false
		
	# Apply impulse in the direction the package is moving from the tween.
	var speed := _package.global_position - _previous_pos
	var momentum := speed * (_package.mass as float) / (1.0/60.0)#delta
	_package.apply_impulse(momentum)
	
	# Watch for the package to come to rest
	_package.sleeping_state_changed.connect(_on_package_sleeping_state_changed)


func _on_package_sleeping_state_changed()->void:
	if _package.sleeping:
		_end_round()


func _end_round()->void:
	var pixel_distance := _package.global_position.x - _man.global_position.x
	var meters := pixel_distance / _pixels_per_meter
	%ScoreLabel.text = "Distance:\n%.2fm" % meters
	%ScoreLabel.visible = true
	
	%ActionControls.visible = false
	%GameOverControls.visible = true
	
	_package.sleeping_state_changed.disconnect(_on_package_sleeping_state_changed)
	
	if meters < 1:
		$Sad.play()
		$Man.show_disappointment()
	else:
		$Polka.play()
		$Man.show_grin()
	
	_record.ending_height = ($Ground.global_position.y - _package.global_position.y) / _pixels_per_meter
	_record.highest = ($Ground.global_position.y - _package.get_highest_y()) / _pixels_per_meter
	_record.distance = meters
	
	var earned_achievements := AchievementPortfolio.find_earned_achievements(_record)
	if not earned_achievements.is_empty():
		var achievement := earned_achievements[0]
		AchievementPortfolio.add(achievement)
		%AchievementArea.visible = true
		%AchievementName.text = achievement.name


func _on_play_again_button_pressed():
	get_tree().change_scene_to_file("res://test_level.tscn")


func _on_package_hit(body:PhysicsBody2D)->void:
	$Suspense.stop()
	_package.hit.disconnect(_on_package_hit)
	
	if body != $Ground:
		_record.made_contact = true


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://ui/title_screen.tscn")


func _on_drop_button_pressed():
	_drop_package()


func _on_kick_pressed():
	_man.kick()
