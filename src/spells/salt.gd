@tool
class_name SaltSpell
extends BaseSpell

static var name := "salt"

static var title := "Salt"
static var description := "Shoots a circle of defense projectiles"

var in_delay := false


func _get_multiplicative(stat: int) -> float:
	if in_delay and stat == PlayerStats.MOVE_SPEED:
		return 0.5
	return 1


func _on_press(source: Player, direction: Vector2) -> void:
	if can_fire():
		in_delay = true
		for deg in range(0, 360, 45):
			spawn(source, direction.rotated(deg_to_rad(deg)))
		await source.cast_animation(name, 1)
		in_delay = false


func _get_modifiers(constants: Dictionary) -> Dictionary:
	constants[DEFENSE] = true
	constants[SIZE] = 1
	constants[DAMAGE] = 3
	constants[SPEED] = 0.75
	constants[DRAG] = 2
	return constants


func _get_cooldown() -> float:
	return 1
