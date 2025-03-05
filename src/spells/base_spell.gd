class_name BaseSpell
extends RefCounted

var bullet := preload("res://scenes/bullet.tscn")
var last_fire := 0
var player: int


func _get_additive(_stat) -> float:
	return 0


func _get_multiplicative(_stat) -> float:
	return 1


func _on_press(_direction: Vector2, _pos: Vector2) -> void:
	pass


func make_bullet(_pos: Vector2) -> Bullet:
	var instance: Bullet = bullet.instantiate()
	Players.get_tree().get_root().add_child(instance)
	instance.position = _pos
	return instance


func spawn_bullet(instance: Bullet, direction: Vector2, size: int) -> void:
	instance.start(player, direction, size)


func can_fire() -> bool:
	if Time.get_ticks_msec() - last_fire > _get_cooldown() * 1000:
		last_fire = Time.get_ticks_msec()
		return true
	return false


func _get_cooldown() -> float:
	return 1
