@tool
class_name LeadSpell
extends BaseSpell

static var name := "lead"

var aiming := false
var speed_factor := 1.5


func _get_multiplicative(stat) -> float:
	if stat == PlayerStats.MOVE_SPEED and aiming:
		return 0
	return 1


func _on_press(_direction: Vector2, _pos: Vector2) -> void:
	if aiming:
		if not can_fire():
			return
		aiming = false
		spawn(_direction, _pos)
	else:
		aiming = true


func spawn(direction: Vector2, pos: Vector2) -> void:
	var instance := make_bullet(pos)
	spawn_bullet(instance, direction)
	await Players.get_tree().create_timer(0.3).timeout
	instance = make_bullet(pos)
	spawn_bullet(instance, direction)


func _get_cooldown() -> float:
	return 1.3
