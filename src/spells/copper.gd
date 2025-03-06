@tool
class_name CopperSpell
extends BaseSpell

static var name := "copper"

static var title := "Copper"
static var description := "Shoots a variable speed projectile with high damage and one bounce"


func _get_modifiers(constants: Dictionary) -> Dictionary:
	constants[SIZE] = 1
	constants[SPEED] = 1.5
	constants[DAMAGE] = 2
	constants[BOUNCES] = 1
	constants[MOVEMENT] = slow_fast_move
	return constants


func slow_fast_move(time: float) -> Vector2:
	return Vector2(sin(time) / 3, 0)


func _get_cooldown() -> float:
	return 0.5
