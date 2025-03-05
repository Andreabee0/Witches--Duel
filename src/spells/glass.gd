@tool
class_name GlassSpell
extends BaseSpell

static var name := "glass"


func _on_press(_direction: Vector2, _pos: Vector2) -> void:
	if can_fire():
		spawn(_direction, _pos)


func spawn(direction: Vector2, pos: Vector2) -> void:
	var instance := make_bullet(pos)
	spawn_bullet(instance, direction, 0)
	instance.set_movement_modifier(zig_move)


func zig_move(time: float) -> Vector2:
	var y := absf(fmod(time + 0.5, 2) - 1) - 0.5
	return Vector2(0, y)


func _get_cooldown() -> float:
	return 0.5
