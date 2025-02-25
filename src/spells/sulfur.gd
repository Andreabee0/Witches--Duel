class_name SulfurSpell
extends BaseSpell


func _get_multiplicative(_stat):
	return 1


func _on_press(_direction: Vector2, _pos: Vector2):
	if can_fire():
		spawn(_direction, _pos)


func spawn(direction: Vector2, pos: Vector2):
	var high := make_bullet(pos)
	var mid := make_bullet(pos)
	var low := make_bullet(pos)
	spawn_bullet(mid, direction)
	spawn_bullet(high, direction.rotated(3.14 / 14))
	spawn_bullet(low, direction.rotated(-3.14 / 14))


func _get_cooldown() -> float:
	return 2
