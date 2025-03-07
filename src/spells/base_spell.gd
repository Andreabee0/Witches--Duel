class_name BaseSpell
extends RefCounted

enum {
	DEFENSE,
	SIZE,
	SPEED,
	DAMAGE,
	HOMING,
	BOUNCES,
	DRAG,
	DRIFT,
	MOVEMENT,
}

static var base = {
	DEFENSE: false,
	SIZE: 0,
	SPEED: 1,
	DAMAGE: 1,
	HOMING: false,
	BOUNCES: 0,
	DRAG: 0,
	DRIFT: 0,
	MOVEMENT: null,
}

var bullet := preload("res://scenes/bullet.tscn")
var defense_bullet := preload("res://scenes/defense_bullet.tscn")
var last_fire := -INF
var player: int


func _get_additive(_stat: int) -> float:
	return 0


func _get_multiplicative(_stat: int) -> float:
	return 1


func _get_modifiers(bullet_stats: Dictionary) -> Dictionary:
	return bullet_stats


func _on_press(source: Player, direction: Vector2) -> void:
	if can_fire():
		await source.cast_animation(self.name)
		spawn(source, direction)


func _on_release(_source: Player, _direction: Vector2) -> void:
	pass


func make_bullet(source: Player, defense := false) -> Bullet:
	var instance: Bullet = defense_bullet.instantiate() if defense else bullet.instantiate()
	source.get_tree().get_root().add_child(instance)
	instance.global_position = source.global_position
	return instance


func spawn(source: Player, direction: Vector2) -> Bullet:
	var constants := _get_modifiers(base.duplicate())
	var instance := make_bullet(source, constants[DEFENSE])
	instance.start(player, direction, constants[SIZE])
	instance.set_speed(constants[SPEED])
	instance.damage = constants[DAMAGE] * Players.get_stat(player, PlayerStats.SPELL_DAMAGE)
	instance.homing = float(constants[HOMING]) + Players.get_stat(player, PlayerStats.SPELL_HOMING)
	instance.bounces = constants[BOUNCES]
	instance.drag = constants[DRAG]
	instance.drift = constants[DRIFT]
	if constants[MOVEMENT]:
		instance.set_movement_modifier(constants[MOVEMENT])
	return instance


func can_fire() -> bool:
	if get_remaining_cooldown() == 0:
		last_fire = Time.get_ticks_msec()
		return true
	return false


func get_remaining_cooldown() -> float:
	var cooldown := get_modified_cooldown()
	var time_passed := (Time.get_ticks_msec() - last_fire) / 1000
	return clampf(cooldown - time_passed, 0, cooldown)


func get_modified_cooldown() -> float:
	return _get_cooldown() * Players.get_stat(player, PlayerStats.SPELL_COOLDOWN)


func _get_cooldown() -> float:
	return 1
