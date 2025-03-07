@tool
class_name PlatinumSpell
extends BaseSpell

static var name := "platinum"

static var title := "Platinum"
static var description := "Shoots a fast defense projectile with strong homing"


func _get_modifiers(constants: Dictionary) -> Dictionary:
	constants[DEFENSE] = true
	constants[SPEED] = 2
	constants[HOMING] = 5
	return constants


func _get_cooldown() -> float:
	return 0.75
