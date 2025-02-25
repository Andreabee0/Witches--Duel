class_name LoversPerk
extends ConstantPerk


func _get_constant_adds() -> Dictionary:
	return {
		PlayerStats.HEALTH: 1,
	}
