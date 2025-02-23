extends CharacterBody2D

@export var SPEED := 800.0

@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	var direction := getMovementVector()

	if !direction.is_zero_approx():
		velocity = direction * SPEED
	else:
		velocity = Vector2(0, 0)

	move_and_slide()

func getMovementVector() -> Vector2:
	return Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
