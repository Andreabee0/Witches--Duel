class_name TemperancePerk
extends ConstantPerk


func get_constant_mults() -> Dictionary:
	return {
		PlayerStats.IFRAME_DURATION: 2,
	}
