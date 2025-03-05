@tool
class_name DevilPerk
extends ConstantPerk

static var name := "devil"

static var title := "The Devil"
static var description := "Doubles damage dealt and taken"


func _get_constant_mults() -> Dictionary:
	return {
		PlayerStats.SPELL_DAMAGE: 2,
		PlayerStats.DAMAGE_TAKEN: 2,
	}
