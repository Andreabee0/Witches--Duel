@tool
class_name IronSpell
extends BaseSpell

static var name := "iron"

static var title := "Iron"
static var description := "Quickly shoots large projectiles in a straight line"


func _on_press(_direction: Vector2, _pos: Vector2) -> void:
	if can_fire():
		spawn(_direction, _pos)


func spawn(direction: Vector2, pos: Vector2) -> void:
	var instance := make_bullet(pos)
	spawn_bullet(instance, direction, 2)


func _get_cooldown() -> float:
	return 0.3
