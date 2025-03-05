@tool
class_name LoversPerk
extends ConstantPerk

static var name := "lovers"

static var title := "The Lovers"
static var description := "Gives a small health boost"


func _get_constant_adds() -> Dictionary:
	return {
		PlayerStats.HEALTH: 1,
	}
