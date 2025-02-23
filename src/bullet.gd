extends Node2D

var direction: Vector2
var speed: float
var size: float

func _init(_direction, _speed, _size):
	var sizeVector = Vector2(size, size)
	direction = _direction.normalized()
	speed = _speed
	size = _size
	
	$CollisionShape2D.scale = sizeVector
	scale = sizeVector
	$sprite.size = sizeVector
	
	
func _physics_process(delta: float) -> void:
	position += direction * delta * speed
