extends StaticBody2D

const _KICK_FORCE := 5000

@onready var _foot := $Leg/ColorRect2

func _physics_process(_delta):
	if Input.is_action_just_pressed("kick"):
		$Leg.apply_impulse(Vector2(_KICK_FORCE,0), _foot.position)
