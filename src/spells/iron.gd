@tool
class_name IronSpell
extends BaseSpell

static var name := "iron"

static var title := "Iron"
static var description := "Quickly shoots large projectiles in a straight line"


func _on_press(source: Node2D, direction: Vector2) -> void:
	if can_fire():
		spawn(source, direction)


func spawn(source: Node2D, direction: Vector2) -> void:
	var instance := make_bullet(source)
	spawn_bullet(instance, direction, 2)


func _get_cooldown() -> float:
	return 0.3
