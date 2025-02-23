class_name BaseSpell
extends Object

var bullet := preload("res://scenes/bullet.tscn")


func spawn(_player: PlayerStats, _direction: Vector2, _pos: Vector2) -> void:
	pass


func spawn_simple(player: PlayerStats, direction: Vector2, pos: Vector2) -> void:
	var instance: Bullet = bullet.instantiate()
	player.add_child(instance)
	instance.position = pos
	instance.start(
		player.player_id,
		direction,
		player.get_stat(PlayerStats.SPELL_SPEED),
		player.get_stat(PlayerStats.SPELL_SIZE)
	)
