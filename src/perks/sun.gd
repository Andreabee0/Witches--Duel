class_name SunPerk
extends ConstantPerk


static var name := "sun"


func _get_constant_mults() -> Dictionary:
	return {
		PlayerStats.SPELL_SPEED: 1.2,
	}
