extends Node2D

func _physics_process(_delta: float) -> void:
	var direction := get_look_vector()

	position += direction * 10

func get_look_vector() -> Vector2:
	return Input.get_vector("look_left", "look_right", "look_up", "look_down")
