class_name FoolPerk
extends ConstantPerk


func get_constant_adds() -> Dictionary:
	return {
		PlayerStats.HEALTH: 2,
		PlayerStats.SPELL_SLOTS: -1,
	}
