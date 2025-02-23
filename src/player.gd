extends CharacterBody2D

@export var speed := 800.0

func _physics_process(_delta: float) -> void:
	var direction := get_movement_vector()

	if !direction.is_zero_approx():
		velocity = direction * speed
	else:
		velocity = Vector2(0, 0)

	move_and_slide()


func get_movement_vector() -> Vector2:
	return Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
