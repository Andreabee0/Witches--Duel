@tool
class_name SunPerk
extends ConstantPerk

static var name := "sun"

static var title := "The Sun"
static var description := "Increases spell speed"


func _get_constant_mults() -> Dictionary:
	return {
		PlayerStats.SPELL_SPEED: 1.2,
	}
