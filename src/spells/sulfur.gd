@tool
class_name SulfurSpell
extends BaseSpell

static var name := "sulfur"

static var title := "Sulfur"
static var description := "Shoots a spread of medium projectiles"


func _on_press(_direction: Vector2, _pos: Vector2) -> void:
	if can_fire():
		spawn(_direction, _pos)


func spawn(direction: Vector2, pos: Vector2) -> void:
	var high := make_bullet(pos)
	var mid := make_bullet(pos)
	var low := make_bullet(pos)
	spawn_bullet(mid, direction, 1)
	spawn_bullet(high, direction.rotated(3.14 / 14), 1)
	spawn_bullet(low, direction.rotated(-3.14 / 14), 1)


func _get_cooldown() -> float:
	return 1
