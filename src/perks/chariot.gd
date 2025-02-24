class_name ChariotPerk
extends ConstantPerk


func get_constant_adds() -> Dictionary:
	return {
		PlayerStats.DASH_COOLDOWN: 0.2,
	}
