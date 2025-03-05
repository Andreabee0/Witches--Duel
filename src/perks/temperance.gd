@tool
class_name TemperancePerk
extends ConstantPerk

static var name := "temperance"

static var title := "Temperance"
static var description := "Doubles invincibility duration after taking damage"


func _get_constant_mults() -> Dictionary:
	return {
		PlayerStats.IFRAME_DURATION: 2,
	}
