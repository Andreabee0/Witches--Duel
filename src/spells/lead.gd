class_name LeadSpell
extends BaseSpell
var aiming = false
var speed_factor := 1.5


func _get_multiplicative(stat):
	if stat == PlayerStats.MOVE_SPEED and aiming:
		return 0
	return 1


func _on_press(_direction: Vector2, _pos: Vector2):
	if aiming:
		aiming = false
		spawn(_direction, _pos)
	else:
		aiming = true


func spawn(direction: Vector2, pos: Vector2):
	var instance := make_bullet(pos)
	spawn_bullet(instance, direction)
	var burst_timer := Timer.new()
	burst_timer.timeout.connect(
		func():
			spawn_bullet(instance, direction)
			burst_timer.queue_free()
	)
	burst_timer.start()
