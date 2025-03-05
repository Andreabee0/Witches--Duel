@tool
class_name GlassSpell
extends BaseSpell

static var name := "glass"

static var title := "Glass"
static var description := "Quickly shoots small projectiles in a zig-zag pattern"


func _on_press(source: Node2D, direction: Vector2) -> void:
	if can_fire():
		spawn(source, direction)


func spawn(source: Node2D, direction: Vector2) -> void:
	var instance := make_bullet(source)
	spawn_bullet(instance, direction, 0)
	instance.set_movement_modifier(zig_move)


func zig_move(time: float) -> Vector2:
	var y := absf(fmod(time + 0.5, 2) - 1) - 0.5
	return Vector2(0, y)


func _get_cooldown() -> float:
	return 0.5
