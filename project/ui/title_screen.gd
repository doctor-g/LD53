extends Control

func _ready():
	if not Globals.show_splash or OS.get_name()!="Web":
		Globals.show_splash = false
		$Camera2D.offset.y += 700
		$Music.play()


func _on_play_button_button_down():
	Sfx.play_click_sound()


func _on_play_button_button_up():
	Sfx.play_click_sound()
	get_tree().change_scene_to_file("res://test_level.tscn")


func _input(event):
	if Globals.show_splash and event is InputEventMouseButton and event.is_pressed():
		Globals.show_splash = false
		$AnimationPlayer.play("move_camera_down")
		$Music.play()
