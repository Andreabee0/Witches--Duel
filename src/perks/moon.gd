@tool
class_name MoonPerk
extends ConstantPerk

static var name := "moon"

static var title := "The Moon"
static var description := "Increases spell size"


func _get_constant_adds() -> Dictionary:
	return {
		PlayerStats.SPELL_SIZE: 1,
	}
