@tool
class_name SulfurSpell
extends BaseSpell

static var name := "sulfur"

static var title := "Sulfur"
static var description := "Sends a number of projectile spreads"


func _on_press(source: Node2D, direction: Vector2) -> void:
	if can_fire():
		for i in 4:
			for deg in range(-15, 16, 7.5):
				spawn(source, direction.rotated(deg_to_rad(deg)))
			await source.get_tree().create_timer(0.2).timeout


func _get_modifiers(constants: Dictionary) -> Dictionary:
	constants[SIZE] = 1
	constants[DRAG] = -0.5
	return constants


func _get_cooldown() -> float:
	return 3
