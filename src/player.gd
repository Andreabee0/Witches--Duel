extends CharacterBody2D

var spell: BaseSpell = LeadSpell.new()
var isCasting := false
var isMoving := false
var direction


func _process(_delta: float) -> void:
	spell.player = $Stats
	if Input.is_action_pressed("use_action_rt"):
		isCasting = true
		spell._on_press(Vector2.from_angle($Cursor.rotation), position)
	if Input.is_action_just_released("use_action_rt"):
		isCasting = false


func _physics_process(_delta: float) -> void:
	direction = get_movement_vector()
	if !direction.is_zero_approx():
		velocity = direction * $Stats.get_stat(PlayerStats.MOVE_SPEED) * 800
		print("isMoving")
		isMoving = true
		if direction.x > 0:
			flipRight()
		if direction.x < 0:
			flipLeft()
	else:
		velocity = Vector2(0, 0)
		isMoving = false
	move_and_slide()


func get_movement_vector() -> Vector2:
	return Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()

func flipLeft():
	$base.flip_h = false
	$robe.flip_h = false
	$belt.flip_h = false
func flipRight():
	$base.flip_h = true
	$robe.flip_h = true
	$belt.flip_h = true

