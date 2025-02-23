extends Node2D

var direction: Vector2
var speed
var size

func _init(_direction, _speed, _size):
	direction = _direction.normalized()
	speed = _speed
	size = _size
	
func _physics_process(delta: float) -> void:
	position += direction * delta * speed
