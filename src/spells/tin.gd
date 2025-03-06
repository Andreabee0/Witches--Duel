@tool
class_name TinSpell
extends ChargeSpell

static var name := "tin"

static var title := "Tin"
static var description := "Charges and shoots increasingly fast and bouncy defense projectiles"


func _on_charge_release(source: Node2D, direction: Vector2) -> void:
	for i in 3:
		spawn(source, direction)
		await source.get_tree().create_timer(0.1).timeout


func _get_modifiers(constants: Dictionary) -> Dictionary:
	constants[DEFENSE] = true
	constants[SIZE] = 2
	constants[DAMAGE] = 3
	constants[SPEED] = clampf(charge_time, 0.5, 2)
	constants[BOUNCES] = clampi(int(charge_time), 0, 4)
	return constants


func _get_cooldown() -> float:
	return 1
