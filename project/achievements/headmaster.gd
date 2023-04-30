extends Achievement

const name := "Headmaster"

func is_earned(record:GameRecord)->bool:
	# Approximation of getting it on the noggin
	return record.ending_height > 1.0
