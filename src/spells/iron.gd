class_name IronSpell
extends BaseSpell


func _on_press(_direction: Vector2, _pos: Vector2) -> void:
	if can_fire():
		spawn(_direction, _pos)


func spawn(direction: Vector2, pos: Vector2) -> void:
	var instance := make_bullet(pos)
	instance.start(
		player.player_id,
		direction,
		player.get_stat(PlayerStats.SPELL_SPEED),
		player.get_stat(PlayerStats.SPELL_SIZE)
	)


func _get_cooldown() -> float:
	return 0.3
