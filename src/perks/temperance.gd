class_name TemperancePerk
extends ConstantPerk


func _get_constant_mults() -> Dictionary:
	return {
		PlayerStats.IFRAME_DURATION: 2,
	}
