@tool
class_name GlassSpell
extends BaseSpell

static var name := "glass"

static var title := "Glass"
static var description := "Shoots a projectile in a fast zig-zag pattern"


func _get_modifiers(constants: Dictionary) -> Dictionary:
	constants[SPEED] = 1.5
	constants[DRAG] = 0.5
	constants[MOVEMENT] = zig_move
	return constants


func zig_move(time: float) -> Vector2:
	var y := absf(fmod(time + 0.5, 2) - 1) - 0.5
	return Vector2(0, y)


func _get_cooldown() -> float:
	return 0.5
