extends Achievement

const name := "Punter"

func is_earned(record:GameRecord)->bool:
	return record.distance > 6.0
