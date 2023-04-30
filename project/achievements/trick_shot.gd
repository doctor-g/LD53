extends Achievement

const name := "Trick Shot"

func is_earned(record:GameRecord)->bool:
	return record.distance < 0
