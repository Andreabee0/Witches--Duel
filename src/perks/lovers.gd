@tool
class_name LoversPerk
extends ConstantPerk

static var name := "lovers"


func _get_constant_adds() -> Dictionary:
	return {
		PlayerStats.HEALTH: 1,
	}
