class_name ConstantPerk
extends BasePerk


func get_constant_adds() -> Dictionary:
	return {}


func get_constant_mults() -> Dictionary:
	return {}


func get_additive(stat) -> float:
	var adds := get_constant_adds()
	if stat in adds:
		return adds[stat]
	return 0


func get_multiplicative(stat) -> float:
	var mults := get_constant_mults()
	if stat in mults:
		return mults[stat]
	return 1
