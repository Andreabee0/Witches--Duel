extends CharacterBody2D

var spell: BaseSpell = LeadSpell.new()
var is_casting := false
var is_moving := false
var id := -1


func _process(_delta: float) -> void:
	spell.player = $Stats
	if Input.is_action_pressed("use_action_rt"):
		is_casting = true
		spell._on_press(Vector2.from_angle($Cursor.rotation), position)
	if Input.is_action_just_released("use_action_rt"):
		is_casting = false


func _physics_process(_delta: float) -> void:
	var direction := get_movement_vector()
	if !direction.is_zero_approx():
		velocity = direction * $Stats.get_stat(PlayerStats.MOVE_SPEED) * 800
		is_moving = true
		if direction.x > 0:
			flip_right()
		if direction.x < 0:
			flip_left()
	else:
		velocity = Vector2(0, 0)
		is_moving = false
	move_and_slide()


func get_movement_vector() -> Vector2:
	return Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()


func flip_left() -> void:
	$base.flip_h = false
	$robe.flip_h = false
	$belt.flip_h = false


func flip_right() -> void:
	$base.flip_h = true
	$robe.flip_h = true
	$belt.flip_h = true


func _on_collider_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		if area.get_parent().source != id:
			print("hit")
