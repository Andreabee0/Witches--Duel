@tool
class_name UrineSpell
extends BaseSpell

static var name := "urine"

static var title := "Urine"
static var description := "Shoots a tiny, pathetic little projectile"


func _get_modifiers(constants: Dictionary) -> Dictionary:
	constants[SPEED] = 0.1
	constants[HOMING] = -0.5
	return constants


func _get_cooldown() -> float:
	return 1
