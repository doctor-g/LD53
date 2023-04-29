extends Node2D

var _tween : Tween
var _previous_pos : Vector2

@onready var _package :RigidBody2D = $Package

func _ready():
	_tween = create_tween()
	_tween.tween_property(_package, "position", _package.position+Vector2(30,0), 1.0).set_trans(Tween.TRANS_CUBIC)
	_tween.tween_property(_package, "position", _package.position-Vector2(30,0), 1.0).set_trans(Tween.TRANS_CUBIC)	
	_tween.set_ease(Tween.EASE_IN_OUT)
	_tween.set_loops()

func _physics_process(delta:float):
	if Input.is_action_just_pressed("drop"):
		_tween.stop()
		$Package.freeze = false
		
		# Apply impulse in the direction the package is moving from the tween.
		var speed := _package.global_position - _previous_pos
		var momentum := speed * ($Package.mass as float) / delta
		$Package.apply_impulse(momentum)

	# Track position so that momentum can be computed
	_previous_pos = _package.global_position
