extends CharacterBody2D

var spell: BaseSpell = SulfurSpell.new()
var isCasting := false
var direction = Vector2.ZERO


func _process(_delta: float) -> void:
	spell.player = $Stats
	if Input.is_action_pressed("use_action_rt"):
		if isCasting == false:
			$AnimatedSprite2D.play("cast")
		isCasting = true
		spell._on_press(Vector2.from_angle($Cursor.rotation), position)
	if Input.is_action_just_released("use_action_rt"):
		$AnimatedSprite2D.play_backwards("cast")


func _physics_process(_delta: float) -> void:
	direction = get_movement_vector()
	if !direction.is_zero_approx():
		velocity = direction * $Stats.get_stat(PlayerStats.MOVE_SPEED) * 800
		if direction.x > 0:
			$AnimatedSprite2D.flip_h = true
		if direction.x < 0:
			$AnimatedSprite2D.flip_h = false
		if !isCasting:
			$AnimatedSprite2D.play("walk")
	else:
		velocity = Vector2(0, 0)
		if !isCasting:
			$AnimatedSprite2D.play("idle")
	move_and_slide()


func get_movement_vector() -> Vector2:
	return Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()



func _on_animated_sprite_2d_animation_finished():
	match $AnimatedSprite2D.animation:
		"cast":
			if $AnimatedSprite2D.frame_progress == 0.0:
				$AnimatedSprite2D.stop()
				isCasting = false
