@tool
class_name BismuthSpell
extends BaseSpell

static var name := "bismuth"

static var title := "Bismuth"
static var description := "Shoots a spread of large defense projectiles after a delay"


func _on_press(source: Player, direction: Vector2) -> void:
	if can_fire():
		await source.cast_animation(name, 0.75)
		for deg in range(-90, 91, 45):
			spawn(source, direction.rotated(deg_to_rad(deg)))


func _get_modifiers(constants: Dictionary) -> Dictionary:
	constants[DEFENSE] = true
	constants[SIZE] = 2
	constants[SPEED] = 0.75
	constants[DRAG] = 0.75
	constants[DAMAGE] = 3
	return constants


func _get_cooldown() -> float:
	return 2
