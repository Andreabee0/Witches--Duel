extends CharacterBody2D

const SPEED = 800.0

@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	var direction = getMovementVector()
	
	if !direction.is_zero_approx():
		velocity = getMovementVector() * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
	
func getMovementVector() -> Vector2:
	return Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
