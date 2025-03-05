@tool
class_name MagicianPerk
extends ConstantPerk

static var name := "magician"

static var title := "The Magician"
static var description := "Reduces spell cooldown"


func _get_constant_mults() -> Dictionary:
	return {
		PlayerStats.SPELL_COOLDOWN: 0.8,
	}
