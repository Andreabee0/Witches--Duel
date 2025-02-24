extends CharacterBody2D

var spell: BaseSpell = LeadSpell.new()


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("use_action_rt"):
		spell.on_press($Stats, Vector2.from_angle($Cursor.rotation), position)


func _physics_process(_delta: float) -> void:
	var direction := get_movement_vector()

	if !direction.is_zero_approx():
		velocity = direction * $Stats.sp
	else:
		velocity = Vector2(0, 0)

	move_and_slide()


func get_movement_vector() -> Vector2:
	return Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
