@tool
class_name GoldSpell
extends BaseSpell

static var name := "gold"

static var title := "Gold"
static var description := "Shoots a very bouncy projectile"


func _get_modifiers(constants: Dictionary) -> Dictionary:
	constants[SIZE] = 1
	constants[BOUNCES] = 10
	return constants


func _get_cooldown() -> float:
	return 0.5
