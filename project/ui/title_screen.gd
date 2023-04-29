extends Control

var _advanced := false

func _ready():
	if OS.get_name()!="Web":
		$Camera2D.offset.y += 700


func _on_play_button_button_down():
	%ClickSound.play()


func _on_play_button_button_up():
	%ClickSound.play()
	await %ClickSound.finished
	get_tree().change_scene_to_file("res://test_level.tscn")


func _input(event):
	if not _advanced and event is InputEventMouseButton and event.is_pressed():
		_advanced=true
		$AnimationPlayer.play("move_camera_down")
