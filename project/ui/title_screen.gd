extends Control


func _on_play_button_button_down():
	%ClickSound.play()


func _on_play_button_button_up():
	%ClickSound.play()
	await %ClickSound.finished
	get_tree().change_scene_to_file("res://test_level.tscn")
