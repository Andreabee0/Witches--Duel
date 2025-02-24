class_name IronSpell
extends BaseSpell


func _on_press(_direction: Vector2, _pos: Vector2):
	spawn(_player, _direction, _pos)


func spawn(direction: Vector2, pos: Vector2):
	var instance := make_bullet(pos)
	instance.start(
		player.player_id,
		direction,
		player.get_stat(PlayerStats.SPELL_SPEED),
		player.get_stat(PlayerStats.SPELL_SIZE)
	)
