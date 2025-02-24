class_name BaseSpell
extends RefCounted

const COOLDOWN_SECS := 1
var bullet := preload("res://scenes/bullet.tscn")
var last_fire = 0
var player: PlayerStats


func _get_additive(_stat) -> float:
	return 0


func _get_multiplicative(_stat) -> float:
	return 1


func _on_press(_direction: Vector2, _pos: Vector2):
	pass


func make_bullet(_pos: Vector2) -> Bullet:
	var instance: Bullet = bullet.instantiate()
	player.add_child(instance)
	instance.position = _pos
	return instance


func spawn_bullet(instance: Bullet, direction: Vector2):
	instance.start(
		player.player_id,
		direction,
		player.get_stat(PlayerStats.SPELL_SPEED),
		player.get_stat(PlayerStats.SPELL_SIZE)
	)


func can_fire() -> bool:
	if Time.get_ticks_msec() - last_fire > COOLDOWN_SECS * 1000:
		last_fire = Time.get_ticks_msec()
		return true
	return false
