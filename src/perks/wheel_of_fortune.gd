@tool
class_name WheelOfFortunePerk
extends BasePerk

static var name := "wheel_of_fortune"

static var title := "Wheel of Fortune"
static var description := "50% chance to dodge, 50% chance to take double damage"


func _get_additive(stat: int) -> float:
	if stat == PlayerStats.DODGE_CHANCE:
		return 0.5
	return super(stat)


func _get_multiplicative(stat: int) -> float:
	if stat == PlayerStats.DAMAGE_TAKEN:
		return 2 if randf() > 0.5 else 1
	return super(stat)
