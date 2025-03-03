class_name TemperancePerk
extends ConstantPerk


static var name := "temperance"


func _get_constant_mults() -> Dictionary:
	return {
		PlayerStats.IFRAME_DURATION: 2,
	}
