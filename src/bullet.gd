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
var damage := 0
var velocity: Vector2
var base_position: Vector2
var homing := 0.0
var bounces := 0
var drag := 0.0
var drift := 0.0
var movement_modifier: Callable
var time := 0.0


func _ready() -> void:
	$Collider/Shape.shape = $Collider/Shape.shape.duplicate()


func start(player: int, _direction: Vector2, _size: int) -> void:
	source = player
	velocity = (
		_direction.normalized() * Players.get_stat(player, PlayerStats.SPELL_SPEED) * BASE_SPEED
	)
	base_position = global_position
	set_size(_size + int(Players.get_stat(player, PlayerStats.SPELL_SIZE)))
	set_color(Players.colors[player].secondary)


func set_size(value: int) -> void:
	size = clamp(value, 0, SIZE_TEXTURES.size() - 1)
	$Collider/Shape.shape.radius = SIZE_RADII[size]
	$Sprite.texture = SIZE_TEXTURES[size]


func set_color(value: Color) -> void:
	color = value
	$Sprite.modulate = value


func set_speed(multiplier: float) -> void:
	velocity *= multiplier


func set_movement_modifier(graph: Callable) -> void:
	time = 0
	movement_modifier = graph


func _physics_process(delta: float) -> void:
	base_position += velocity * delta * UNIT_SCALE
	if drag != 0:
		velocity -= velocity * drag * delta
	if drift != 0:
		velocity = velocity.rotated(delta * drift * PI)
		drift -= drift * delta * 2
	if movement_modifier:
		var current_speed := velocity.length()
		time += delta * current_speed
		var mod: Vector2 = movement_modifier.call(time) * UNIT_SCALE
		global_position = base_position + mod.rotated(velocity.angle())
	else:
		global_position = base_position
