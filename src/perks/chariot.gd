@tool
class_name ChariotPerk
extends ConstantPerk

static var name := "chariot"

static var title := "The Chariot"
static var description := "Reduces dash cooldown"


func _get_constant_adds() -> Dictionary:
	return {
		PlayerStats.DASH_COOLDOWN: -0.2,
	}
