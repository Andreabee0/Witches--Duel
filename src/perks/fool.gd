@tool
class_name FoolPerk
extends ConstantPerk

static var name := "fool"

static var title := "The Fool"
static var description := "Grants extra health at the cost of a spell slot"


func _get_constant_adds() -> Dictionary:
	return {
		PlayerStats.HEALTH: 2,
		PlayerStats.SPELL_SLOTS: -1,
	}
