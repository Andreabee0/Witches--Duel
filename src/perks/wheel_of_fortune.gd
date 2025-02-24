class_name WheelOfFortunePerk
extends BasePerk


func get_multiplicative(stat) -> float:
	if stat == PlayerStats.DODGE_CHANCE:
		return 0.5
	if stat == PlayerStats.SPELL_DAMAGE:
		return 2 if randf() > 0.5 else 1
	return 1
