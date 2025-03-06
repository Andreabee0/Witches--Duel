@tool
class_name SilverSpell
extends BaseSpell

const SPACING := 300

static var name := "silver"

static var title := "Silver"
static var description := "Rains defensive projectiles from the top of the screen"


func _on_press(source: Node2D, _direction: Vector2) -> void:
	if can_fire():
		var viewport := source.get_viewport_rect()
		var top_pos := SPACING * -0.5
		while top_pos < viewport.size.x - 2:
			if top_pos > 0:
				var angle := deg_to_rad(randf_range(95, 85))
				var pos := viewport.position + Vector2.RIGHT * (top_pos + 1)
				spawn(source, Vector2.from_angle(angle)).base_position = pos
			top_pos += SPACING * randf_range(0.5, 1.5)


func _get_modifiers(constants: Dictionary) -> Dictionary:
	constants[DEFENSE] = true
	constants[SIZE] = 1
	constants[DRAG] = -1
	return constants


func _get_cooldown() -> float:
	return 4
