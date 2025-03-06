@tool
class_name FireSpell
extends ChargeSpell

static var name := "fire"

static var title := "Fire"
static var description := "Charges and expels a number of homing projectiles"


func _on_charge_release(source: Node2D, _direction: Vector2) -> void:
	for i in int(charge_time * 8):
		spawn(source, Util.rand_vec())


func _get_modifiers(constants: Dictionary) -> Dictionary:
	constants[SPEED] = 1.5
	constants[HOMING] = 1
	constants[DRAG] = 0.5
	return constants


func _get_cooldown() -> float:
	return 0.5
