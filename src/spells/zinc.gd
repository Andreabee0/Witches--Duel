@tool
class_name ZincSpell
extends BaseSpell

static var name := "zinc"

static var title := "Zinc"
static var description := "Shoots a large accelerating defense projectile"


func _get_modifiers(constants: Dictionary) -> Dictionary:
	constants[DEFENSE] = true
	constants[SIZE] = 2
	constants[DAMAGE] = 4
	constants[BOUNCES] = 2
	constants[DRAG] = -1
	constants[HOMING] = 1
	return constants


func _get_cooldown() -> float:
	return 0.5
