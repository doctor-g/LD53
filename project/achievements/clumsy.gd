extends Achievement

const name := "Clumsy"

func is_earned(record:GameRecord)->bool:
	return not record.made_contact
