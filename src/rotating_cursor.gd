extends Node2D


func update_look(device: DeviceInput):
	var direction := get_look_vector(device)
	position = direction * 100
	rotation = Vector2(1, 0).angle_to(direction)
	visible = position.length() > 1


func get_look_vector(device: DeviceInput) -> Vector2:
	return device.get_vector("look_left", "look_right", "look_up", "look_down")
