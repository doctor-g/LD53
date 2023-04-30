class_name Man
extends StaticBody2D

const _KICK_FORCE := 5000

@export var object : Node2D

@export_group("Debugging")
@export var draw_impulse := false

@onready var _foot := $Leg/FootCollision
@onready var _mouths := [
	%MouthGrin,
	%MouthOoh,
	%MouthDisappoint
]

var _impulse : Vector2
var _at : Vector2

var _detected_high_kick := false

func _ready():
	$LeftEye.object = object
	$RightEye.object = object


func _physics_process(_delta):
	if Input.is_action_just_pressed("kick"):
		kick()
	
	if not _detected_high_kick and object.global_position.y < $LeftEye.global_position.y:
		show_excitement()
		_detected_high_kick = true


func _draw():
	if draw_impulse:
		draw_line(_at, _impulse, Color.BLACK, 5)
	
	
func kick()->void:
	var impulse := Vector2(_KICK_FORCE, 0).rotated(_foot.get_global_transform().get_rotation())
	_impulse = impulse
	_at = _foot.global_position - global_position
	$Leg.apply_impulse(impulse, _at)
	queue_redraw()


func show_grin()->void:
	_show_mouth(%MouthGrin)


func show_excitement()->void:
	_show_mouth(%MouthOoh)
	
	
func show_disappointment()->void:
	_show_mouth(%MouthDisappoint)


func _show_mouth(value:Sprite2D)->void:
	for mouth in _mouths:
		mouth.visible = mouth == value
