class_name IronSpell
extends BaseSpell

static var name := "iron"


func _on_press(_direction: Vector2, _pos: Vector2) -> void:
	if can_fire():
		spawn(_direction, _pos)


func spawn(direction: Vector2, pos: Vector2) -> void:
	var instance := make_bullet(pos)
	spawn_bullet(instance, direction)


func _get_cooldown() -> float:
	return 0.3
