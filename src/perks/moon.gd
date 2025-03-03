class_name MoonPerk
extends ConstantPerk


static var name := "moon"


func _get_constant_mults() -> Dictionary:
	return {
		PlayerStats.SPELL_SIZE: 1.2,
	}
