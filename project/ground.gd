extends StaticBody2D

@onready var _shape :RectangleShape2D = $CollisionShape2D.shape

func _draw():
	var rect := Rect2(-_shape.size.x/2, -_shape.size.y/2, _shape.size.x, _shape.size.y)
	draw_rect(rect, Color.DARK_GREEN)
