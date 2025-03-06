@tool
class_name AirSpell
extends BaseSpell

static var name := "air"

static var title := "Air"
static var description := "Shoots fast, swirly projectiles in both directions"


func _on_press(source: Player, direction: Vector2) -> void:
	if can_fire():
		await source.cast_animation(name)
		for i in 3:
			spawn(source, direction)
			spawn(source, -direction)
			await source.get_tree().create_timer(0.1).timeout


func _get_modifiers(constants: Dictionary) -> Dictionary:
	constants[SPEED] = 1.5
	constants[HOMING] = 0.5
	constants[MOVEMENT] = circle_move
	return constants


func circle_move(time: float) -> Vector2:
	return Vector2.LEFT / 2 + Vector2.from_angle(time * -4) / 2


func _get_cooldown() -> float:
	return 0.75
