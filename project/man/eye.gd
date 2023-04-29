extends Node2D

@export var radius := 25.0
@export var outline_width := 3.0
@export var pupil_radius := 6.0

@export var object : Node2D

var _last_known_position : Vector2

func _physics_process(_delta):
	if object!=null:
		if object.global_position != _last_known_position:
			_last_known_position = object.global_position
			queue_redraw()


func _draw():
	draw_circle(Vector2.ZERO, radius, Color.BLACK)
	draw_circle(Vector2.ZERO, radius-outline_width, Color.WHITE_SMOKE)
	
	# Pupil
	var pupil_position := Vector2.ZERO
	if object!=null:
		var angle := global_position.angle_to_point(object.global_position)
		pupil_position = Vector2(radius-pupil_radius-outline_width, 0).rotated(angle)
	draw_circle(pupil_position, pupil_radius, Color.BLACK)
