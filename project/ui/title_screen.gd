extends Control

func _ready():
	if not Globals.show_splash or OS.get_name()!="Web":
		Globals.show_splash = false
		$Camera2D.offset.y += 700
		$Music.play()
	
	%AchievementsButton.text = "Achievements (%d/%d)" % [
			AchievementPortfolio.count_earned(), 
			AchievementPortfolio.CATALOG.size(),
	]


func _input(event):
	if Globals.show_splash and event is InputEventMouseButton and event.is_pressed():
		Globals.show_splash = false
		$AnimationPlayer.play("move_camera_down")
		$Music.play()


func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://test_level.tscn")


func _on_achievements_button_pressed():
	$AchievementsPopup.popup_centered()
