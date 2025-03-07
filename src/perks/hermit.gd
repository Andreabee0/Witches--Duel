@tool
class_name HermitPerk
extends ConstantPerk

static var name := "hermit"

static var title := "The Hermit"
static var description := "Reduces hitbox size"


func _get_constant_mults() -> Dictionary:
	return {
		PlayerStats.HITBOX: 0.8,
	}
