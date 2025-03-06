@tool
class_name WaterSpell
extends BaseSpell

static var name := "water"

static var title := "Water"
static var description := "Shoots a spiral of projectiles"

var drift := 2


func _on_press(source: Node2D, direction: Vector2) -> void:
	if can_fire():
		drift = -drift
		for deg in range(0, 360, 36):
			spawn(source, direction.rotated(deg_to_rad(deg))).drift = drift


func _get_modifiers(constants: Dictionary) -> Dictionary:
	constants[SIZE] = 1
	constants[SPEED] = 1.5
	return constants


func _get_cooldown() -> float:
	return 1
