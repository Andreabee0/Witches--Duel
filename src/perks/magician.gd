class_name MagicianPerk
extends ConstantPerk


static var name := "magician"


func _get_constant_mults() -> Dictionary:
	return {
		PlayerStats.SPELL_COOLDOWN: 0.8,
	}
