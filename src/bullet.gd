extends Node2D

var source: int
var velocity: Vector2
var speed: float
var size: float
var homing: float


func _init(_source, _direction, _speed, _size):
	source = _source
	velocity = _direction.normalized()
	speed = _speed
	size = _size

	var size_vector = Vector2(_size, _size)
	scale = size_vector
	$CollisionShape2D.scale = size_vector
	$sprite.size = size_vector


func _physics_process(delta: float) -> void:
	position += velocity * delta * speed
