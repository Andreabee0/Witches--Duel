@tool
class_name LeadSpell
extends BaseSpell

static var name := "lead"

static var title := "Lead"
static var description := "Aims, locking you in place, then shoots multiple fast medium projectiles"

var aiming := false
var speed_factor := 1.5


func _get_multiplicative(stat: int) -> float:
	if stat == PlayerStats.MOVE_SPEED and aiming:
		return 0
	return super(stat)


func _on_release(source: Node2D, direction: Vector2) -> void:
	if aiming:
		if not can_fire():
			return
		aiming = false
		spawn(source, direction)
	else:
		aiming = true


func spawn(source: Node2D, direction: Vector2) -> void:
	var instance := make_bullet(source)
	spawn_bullet(instance, direction, 0)
	instance.set_speed(speed_factor)
	await Players.get_tree().create_timer(0.3).timeout
	instance = make_bullet(source)
	spawn_bullet(instance, direction, 0)
	instance.set_speed(speed_factor)


func _get_cooldown() -> float:
	return 1.3
