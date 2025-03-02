@tool
extends Node2D

@export var speed := 250.0

@export var color := Color.WHITE:
	set = set_color

var selections: Selections


func set_color(value: Color) -> void:
	color = value
	$Sprite.modulate = color


func _ready() -> void:
	set_color(color)


func _process(delta: float) -> void:
	var direction := get_move_vector()
	if direction.length() > 0.1:
		rotation = Vector2(0, -1).angle_to(direction)
	position += direction * delta * speed
	if selections:
		selections.cursor_position = global_position


func get_move_vector() -> Vector2:
	if not selections:
		return Vector2.ZERO
	return selections.device.get_vector("move_left", "move_right", "move_up", "move_down")
