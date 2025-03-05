class_name BaseSpell
extends RefCounted

var bullet := preload("res://scenes/bullet.tscn")
var last_fire := 0
var player: int


func _get_additive(_stat: int) -> float:
	return 0


func _get_multiplicative(_stat: int) -> float:
	return 1


func _on_press(_source: Node2D, _direction: Vector2) -> void:
	pass


func _on_release(_source: Node2D, _direction: Vector2) -> void:
	pass


func make_bullet(source: Node2D) -> Bullet:
	var instance: Bullet = bullet.instantiate()
	source.get_tree().get_root().add_child(instance)
	instance.global_position = source.global_position
	return instance


func spawn_bullet(instance: Bullet, direction: Vector2, size: int) -> void:
	instance.start(player, direction, size)


func can_fire() -> bool:
	var cooldown := _get_cooldown() * Players.get_stat(player, PlayerStats.SPELL_COOLDOWN)
	if Time.get_ticks_msec() - last_fire > cooldown * 1000:
		last_fire = Time.get_ticks_msec()
		return true
	return false


func _get_cooldown() -> float:
	return 1
