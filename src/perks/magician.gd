class_name MagicianPerk
extends ConstantPerk


func get_constant_mults() -> Dictionary:
	return {
		PlayerStats.SPELL_COOLDOWN: 0.8,
	}
