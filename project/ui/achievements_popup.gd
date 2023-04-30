extends Popup

@onready var _vbox := %AchievementsList

func _ready():
	for achievement in AchievementPortfolio.CATALOG:
		var label := Label.new()
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		_vbox.add_child(label)
		
		if AchievementPortfolio.is_earned(achievement):
			label.text = achievement.name
		else:
			label.text = "???"
	

func _on_ok_button_pressed():
	hide()
