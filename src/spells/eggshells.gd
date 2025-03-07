@tool
class_name EggshellsSpell
extends BaseSpell

static var name := "eggshells"

static var title := "Eggshells"
static var description := "Shoots a dense spread of defense projectiles"


func _on_press(source: Player, direction: Vector2) -> void:
	if can_fire():
		await source.cast_animation(name, 0.5)
		for deg in range(-15, 16, 10):
			spawn(source, direction.rotated(deg_to_rad(deg)))


func _get_modifiers(constants: Dictionary) -> Dictionary:
	constants[DEFENSE] = true
	constants[SIZE] = 1
	constants[SPEED] = 0.75
	constants[DAMAGE] = 5
	constants[DRAG] = 2
	return constants


func _get_cooldown() -> float:
	return 2.5
