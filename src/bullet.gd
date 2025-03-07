@tool
class_name Bullet
extends StaticBody2D

const SIZE_TEXTURES: Array[Texture2D] = [
	preload("res://sprites/projectile_small.png"),
	preload("res://sprites/projectile_med.png"),
	preload("res://sprites/projectile_large.png"),
	preload("res://sprites/projectile_huge.png"),
]

const SIZE_RADII: Array[float] = [20, 35, 49, 65]

const BASE_SPEED := 5
const UNIT_SCALE := 100
const DESPAWN_TIME := 30

@export var size := 0:
	set = set_size

@export var color := Color.WHITE:
	set = set_color

var source: int
var damage := 0
var base_position: Vector2
var homing := 0.0
var bounces := 0
var drag := 0.0
var drift := 0.0
var movement_modifier: Callable
var time := 0.0
var has_avoided_collision := false
var existence_time := 0.0

@onready var collider_shape = $Shape


func _ready() -> void:
	collider_shape.shape = collider_shape.shape.duplicate()


func start(player: int, _direction: Vector2, _size: int) -> void:
	source = player
	constant_linear_velocity = (
		_direction.normalized() * Players.get_stat(player, PlayerStats.SPELL_SPEED) * BASE_SPEED
	)
	base_position = position
	set_size(_size + int(Players.get_stat(player, PlayerStats.SPELL_SIZE)))
	set_color(Players.colors[player].secondary)


func set_size(value: int) -> void:
	size = clamp(value, 0, SIZE_TEXTURES.size() - 1)
	if collider_shape:
		collider_shape.shape.radius = SIZE_RADII[size]
		$Sprite.texture = SIZE_TEXTURES[size]


func set_color(value: Color) -> void:
	color = value
	$Sprite.modulate = value


func set_speed(multiplier: float) -> void:
	constant_linear_velocity *= multiplier


func set_movement_modifier(graph: Callable) -> void:
	time = 0
	movement_modifier = graph


func is_defense() -> bool:
	return false


func _physics_process(delta: float) -> void:
	existence_time += delta
	if existence_time > DESPAWN_TIME or constant_linear_velocity.length() < 0.05:
		queue_free()
		return
	position = base_position
	var movement := constant_linear_velocity * delta * UNIT_SCALE
	var collision: KinematicCollision2D = null
	var out_of_bounds := not GlobalInfo.current_arena_bounds.has_point(global_position)
	if not out_of_bounds:
		collision = move_and_collide(movement, not has_avoided_collision)
		if not has_avoided_collision:
			position += movement
	else:
		position += movement
	base_position = position
	handle_drag_drift(delta)
	if homing != 0:
		handle_homing(delta)
	if movement_modifier:
		handle_movement_modifier(delta)
	if collision:
		if has_avoided_collision:
			handle_collision(collision)
	elif not out_of_bounds:
		has_avoided_collision = true


func handle_drag_drift(delta: float) -> void:
	if drag != 0:
		constant_linear_velocity -= constant_linear_velocity * drag * delta
	if drift != 0:
		constant_linear_velocity = constant_linear_velocity.rotated(delta * drift * PI)
		drift -= drift * delta * 2


func handle_homing(delta: float) -> void:
	var closest_pos := Vector2.INF
	for node in get_tree().get_nodes_in_group("players"):
		if not node is Player:
			continue
		var player: Player = node
		if player.info.device.device == source:
			continue
		var distance_vector := player.global_position - global_position
		if not closest_pos.is_finite() or distance_vector.length() < closest_pos.length():
			closest_pos = distance_vector
	if closest_pos.is_finite():
		home_towards(closest_pos, delta)


func home_towards(direction: Vector2, delta: float):
	var angle := constant_linear_velocity.angle_to(direction)
	angle *= (1 - 1 / (homing * delta / 2 + 1))
	constant_linear_velocity = constant_linear_velocity.rotated(angle)


func handle_movement_modifier(delta: float) -> void:
	var current_speed := constant_linear_velocity.length()
	time += delta * current_speed
	var mod: Vector2 = movement_modifier.call(time) * UNIT_SCALE
	base_position = position
	position = base_position + mod.rotated(constant_linear_velocity.angle())


func handle_collision(collision: KinematicCollision2D) -> void:
	if not collision.get_collider() is Node:
		return
	var collided: Node = collision.get_collider()
	if collided.is_in_group("tiles"):
		if bounces == 0:
			queue_free()
		else:
			constant_linear_velocity = constant_linear_velocity.bounce(collision.get_normal())
			bounces -= 1
	elif collided.is_in_group("defense_bullets") and collided is DefenseBullet:
		var bullet: Bullet = collided
		queue_free()
		bullet.damage -= 1
		if bullet.damage == 0:
			bullet.queue_free()
