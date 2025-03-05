@tool
class_name SulfurSpell
extends BaseSpell

static var name := "sulfur"

static var title := "Sulfur"
static var description := "Shoots a spread of medium projectiles"


func _on_press(source: Node2D, direction: Vector2) -> void:
	if can_fire():
		spawn(source, direction)


func spawn(source: Node2D, direction: Vector2) -> void:
	var high := make_bullet(source)
	var mid := make_bullet(source)
	var low := make_bullet(source)
	spawn_bullet(mid, direction, 1)
	spawn_bullet(high, direction.rotated(PI / 14), 1)
	spawn_bullet(low, direction.rotated(-PI / 14), 1)


func _get_cooldown() -> float:
	return 1
