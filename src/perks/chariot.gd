@tool
class_name ChariotPerk
extends ConstantPerk

static var name := "chariot"


func _get_constant_adds() -> Dictionary:
	return {
		PlayerStats.DASH_COOLDOWN: 0.2,
	}
