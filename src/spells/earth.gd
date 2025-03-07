@tool
class_name EarthSpell
extends BaseSpell

const SPACING := 400

static var name := "earth"

static var title := "Earth"
static var description := "Sends tremors across the map in the aimed direction"


func _on_press(source: Player, direction: Vector2) -> void:
	if can_fire():
		await source.get_tree().create_timer(1).timeout
		var viewport := source.get_viewport_rect()
		var angle = direction.angle()
		if angle < 0:
			angle += PI * 2
		var start_corner := get_corner(viewport, angle)
		var min_offset := calc_min_offset(viewport.size, angle)
		var max_offset := calc_max_offset(viewport.size, angle)
		var offset := min_offset - SPACING * 0.5
		var offset_vec := direction.orthogonal()
		while offset < max_offset:
			if offset > min_offset:
				var pos := start_corner + offset_vec * offset
				spawn(source, direction).base_position = pos
			offset += SPACING * randf_range(0.5, 1.5)


func get_corner(rect: Rect2, angle: float) -> Vector2:
	if angle > PI * 3 / 2:
		return rect.position + Vector2(0, rect.size.y)
	if angle > PI:
		return rect.end
	if angle > PI / 2:
		return rect.position + Vector2(rect.size.x, 0)
	return rect.position


func calc_min_offset(rect_size: Vector2, angle: float) -> float:
	var flag := fmod(angle, PI) > PI / 2
	return -cos(fmod(angle, PI / 2)) * (rect_size.x if flag else rect_size.y)


func calc_max_offset(rect_size: Vector2, angle: float) -> float:
	var flag := fmod(angle, PI) > PI / 2
	return cos(PI / 2 - fmod(angle, PI / 2)) * (rect_size.y if flag else rect_size.x)


func _get_modifiers(constants: Dictionary) -> Dictionary:
	constants[SIZE] = 2
	constants[DAMAGE] = 2
	constants[SPEED] = 0.75
	constants[MOVEMENT] = jitter_move
	return constants


# just zigzag, but faster and smaller
func jitter_move(time: float) -> Vector2:
	var y := absf(fmod(time * 8 + 0.5, 2) - 1) - 0.5
	return Vector2(0, y / 8)


func _get_cooldown() -> float:
	return 2
