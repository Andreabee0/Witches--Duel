class_name BasePerk
extends RefCounted

var player: int


func _get_additive(_stat: int) -> float:
	return 0


func _get_multiplicative(_stat: int) -> float:
	return 1


func post_init() -> void:
	pass


func update(_delta: float) -> void:
	pass
