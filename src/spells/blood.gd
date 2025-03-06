@tool
class_name BloodSpell
extends BaseSpell

static var name := "blood"

static var title := "Blood"
static var description := "Shoots projectiles in a helix"


func _on_press(source: Node2D, direction: Vector2) -> void:
	if can_fire():
		for i in 2:
			spawn(source, direction).set_movement_modifier(helix_move.bind(i % 2 == 0))


func _get_modifiers(constants: Dictionary) -> Dictionary:
	constants[SIZE] = 1
	return constants


func helix_move(time: float, invert: bool) -> Vector2:
	return Vector2(0, sin(time * 2) / 2 * (-1 if invert else 1))


func _get_cooldown() -> float:
	return 0.5
