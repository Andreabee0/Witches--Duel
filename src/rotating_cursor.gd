extends Node2D


func _physics_process(_delta: float) -> void:
	var direction := get_look_vector()
	position = direction * 100
	rotation = Vector2(1, 0).angle_to(direction)
	visible = position.length() > 1


func get_look_vector() -> Vector2:
	var look := Input.get_vector("look_left", "look_right", "look_up", "look_down")
	return look.clamp(Vector2(-1, -1), Vector2(1, 1))

