@tool
class_name Bullet
extends Node2D

const SIZE_TEXTURES: Array[Texture2D] = [
	preload("res://sprites/projectile_small.png"),
	preload("res://sprites/projectile_med.png"),
	preload("res://sprites/projectile_large.png"),
	preload("res://sprites/projectile_huge.png"),
]

const SIZE_RADII: Array[float] = [20, 35, 49, 65]

const BASE_SPEED := 5
const UNIT_SCALE := 100

@export var size := 0:
	set = set_size

@export var color := Color.WHITE:
	set = set_color

var source: int
var velocity: Vector2
var base_position: Vector2
var movement_modifier: Callable
var time := 0.0
var bounces: int
var homing: float


func _ready() -> void:
	$Collider/Shape.shape = $Collider/Shape.shape.duplicate()


func start(player: int, _direction: Vector2, _size: int) -> void:
	source = player
	velocity = (
		_direction.normalized() * Players.get_stat(player, PlayerStats.SPELL_SPEED) * BASE_SPEED
	)
	base_position = position
	set_size(_size + int(Players.get_stat(player, PlayerStats.SPELL_SIZE)))
	set_color(Players.colors[player].secondary)


func set_size(value: int):
	size = clamp(value, 0, SIZE_TEXTURES.size() - 1)
	$Collider/Shape.shape.radius = SIZE_RADII[size]
	$Sprite.texture = SIZE_TEXTURES[size]


func set_color(value: Color):
	color = value
	$Sprite.modulate = value


func set_speed(multiplier: float):
	velocity *= multiplier


func set_movement_modifier(graph: Callable) -> void:
	bounces = 0
	time = 0
	movement_modifier = graph


func set_bounces(value: int):
	if not movement_modifier:
		bounces = value


func _physics_process(delta: float) -> void:
	base_position += velocity * delta * UNIT_SCALE
	if movement_modifier:
		var current_speed := velocity.length()
		time += delta * current_speed
		var mod: Vector2 = movement_modifier.call(time) * UNIT_SCALE
		position = base_position + mod.rotated(velocity.angle())
	else:
		position = base_position
