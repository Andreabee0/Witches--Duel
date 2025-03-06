@tool
class_name LeadSpell
extends BaseSpell

static var name := "lead"

static var title := "Lead"
static var description := "Shoots a simple but high-damage projectile"


func _get_modifiers(constants: Dictionary) -> Dictionary:
	constants[SIZE] = 1
	constants[DAMAGE] = 2
	return constants


func _get_cooldown() -> float:
	return 0.5
