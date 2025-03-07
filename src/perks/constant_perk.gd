@tool
class_name ConstantPerk
extends BasePerk


func _get_constant_adds() -> Dictionary:
	return {}


func _get_constant_mults() -> Dictionary:
	return {}


func _get_additive(stat: int) -> float:
	var adds := _get_constant_adds()
	if stat in adds:
		return adds[stat]
	return super(stat)


func _get_multiplicative(stat: int) -> float:
	var mults := _get_constant_mults()
	if stat in mults:
		return mults[stat]
	return super(stat)
