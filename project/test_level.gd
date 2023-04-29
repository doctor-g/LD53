extends Node2D

func _physics_process(_delta):
	if Input.is_action_just_pressed("drop"):
		$Package.freeze = false
