extends Node

## All possible achievements
##
## Treat as a constant, please.
var CATALOG : Array[Achievement] = [
	preload("res://achievements/first_timer.gd").new(),
	preload("res://achievements/headmaster.gd").new(),
	preload("res://achievements/trick_shot.gd").new(),
	preload("res://achievements/clumsy.gd").new(),
	preload("res://achievements/punter.gd").new(),
	preload("res://achievements/sky_high.gd").new(),
]

var _earned : Array[Achievement] = []


func count_earned()->int:
	return _earned.size()


func find_earned_achievements(record:GameRecord)->Array[Achievement]:
	var result : Array[Achievement] = []
	for achievement in CATALOG:
		if not _earned.has(achievement) and achievement.is_earned(record):
			result.append(achievement)
	return result
	

func is_earned(achievement:Achievement)->bool:
	return _earned.has(achievement)


func add(earned_achievement:Achievement)->void:
	assert(not _earned.has(earned_achievement))
	_earned.append(earned_achievement)
