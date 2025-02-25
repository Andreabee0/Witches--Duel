class_name ChariotPerk
extends ConstantPerk


func _get_constant_adds() -> Dictionary:
	return {
		PlayerStats.DASH_COOLDOWN: 0.2,
	}
