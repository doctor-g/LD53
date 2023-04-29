extends StaticBody2D

const _KICK_FORCE := 5000

@export_group("Debugging")
@export var draw_impulse := false

@onready var _foot := $Leg/ColorRect2

var _impulse : Vector2
var _at : Vector2

func _physics_process(_delta):
	if Input.is_action_just_pressed("kick"):
		var impulse := Vector2(_KICK_FORCE, 0).rotated(_foot.get_global_transform().get_rotation())
		_impulse = impulse
		_at = _foot.global_position - global_position
		$Leg.apply_impulse(impulse, _at)
		
		queue_redraw()


func _draw():
	if draw_impulse:
		draw_line(_at, _impulse, Color.BLACK, 5)
	
