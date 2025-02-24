class_name Bullet
extends Node2D

var source: int
var velocity: Vector2
var speed: float
var size: float
var homing: float


func start(_source: int, _direction: Vector2, _speed: float, _size: float) -> void:
	source = _source
	velocity = _direction.normalized()
	speed = _speed * 1000
	size = _size * 0.1

	scale = Vector2(size, size)


func _physics_process(delta: float) -> void:
	position += velocity * delta * speed
