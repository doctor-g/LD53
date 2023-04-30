extends Achievement

const name := "Sky High"

func is_earned(record:GameRecord)->bool:
	return record.highest > 4.0
