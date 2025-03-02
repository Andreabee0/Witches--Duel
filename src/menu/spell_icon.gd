@tool
class_name SpellIcon
extends Control

const BUTTONS: Array[Texture2D] = [
	preload("res://sprites/menu/left_trigger.png"),
	preload("res://sprites/menu/left_button.png"),
	preload("res://sprites/menu/right_trigger.png"),
	preload("res://sprites/menu/right_button.png"),
]

@export var selection := -1:
	set = set_selection

@export var color := Color.WHITE:
	set = set_color


func set_selection(value: int) -> void:
	selection = clamp(value, -1, 3)
	var enabled := selection >= 0
	$Filling.visible = enabled
	$Button.visible = enabled
	if enabled:
		$Button.texture = BUTTONS[selection]


func set_color(value: Color) -> void:
	color = value
	$Filling.modulate = color


func _ready() -> void:
	set_color(color)
	set_selection(selection)
