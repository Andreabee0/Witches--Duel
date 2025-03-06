@tool
class_name MercurySpell
extends BaseSpell

const SPACING := 300

static var name := "mercury"

static var title := "Mercury"
static var description := "Invades the screen with swirls of projectiles"

var in_delay := false


func _get_additive(stat: int) -> float:
	if in_delay and stat == PlayerStats.SPELL_COOLDOWN:
		return 999
	return 0


func _on_press(source: Node2D, _direction: Vector2) -> void:
	if can_fire():
		in_delay = true
		await source.get_tree().create_timer(2).timeout
		in_delay = false
		var viewport := source.get_viewport_rect()
		var sides_pos := SPACING * -0.25
		while sides_pos < (viewport.size.x + viewport.size.y) * 2 - 2:
			if sides_pos > 0:
				var side := get_rect_side(sides_pos + 1, viewport.size)
				var side_idx: int = side[0]
				var side_pos: float = side[1]
				var angle := deg_to_rad(randf_range(135, 45) + float(side_idx * 90))
				spawn(source, Vector2.from_angle(angle)).base_position = get_side_vec(
					viewport, side_idx, side_pos
				)
			sides_pos += SPACING * randf_range(0.25, 2.5)


func get_rect_side(pos: float, rect_size: Vector2) -> Array:
	var side := 0
	if pos > rect_size.x:
		side += 1
		pos -= rect_size.x
	if pos > rect_size.y:
		side += 1
		pos -= rect_size.y
	if pos > rect_size.x:
		side += 1
		pos -= rect_size.x
	return [side, pos]


func get_side_vec(rect: Rect2, side: int, side_pos: float) -> Vector2:
	var start := rect.position
	if side == 1:
		start.x += rect.size.x
	elif side == 2:
		start.y += rect.size.y
	var direction := Vector2.RIGHT if side % 2 == 0 else Vector2.DOWN
	return start + direction * side_pos


func _get_modifiers(constants: Dictionary) -> Dictionary:
	constants[SPEED] = 1.5
	constants[BOUNCES] = 2
	constants[DRIFT] = randf_range(1, 2) * (-1 if Util.randb() else 1)
	return constants


func _get_cooldown() -> float:
	return 5
