@tool
extends Node2D

@export var speed := 400.0

@export var screen_margin := 10

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
	clamp_in_viewport()
	if selections:
		selections.cursor_position = global_position


func clamp_in_viewport() -> void:
	var rect := get_viewport_rect()
	rect = rect.grow(-screen_margin)
	position = position.clamp(rect.position, rect.end)


func get_move_vector() -> Vector2:
	if not selections:
		return Vector2.ZERO
	return selections.device.get_vector("move_left", "move_right", "move_up", "move_down")
