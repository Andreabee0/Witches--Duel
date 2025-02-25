class_name DevilPerk
extends ConstantPerk


func _get_constant_mults() -> Dictionary:
	return {
		PlayerStats.SPELL_DAMAGE: 2,
		PlayerStats.DAMAGE_TAKEN: 2,
	}
