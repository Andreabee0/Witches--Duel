@tool
extends Control

@export var selection := -1:
	set = set_selection

@export var color := Color.WHITE:
	set = set_color


func set_selection(value: int):
	selection = clamp(value, -1, 3)
	var enabled := selection >= 0
	$Filling.visible = enabled


func set_color(value: Color):
	color = value
	$Filling.modulate = color


func _ready() -> void:
	set_color(color)
	set_selection(selection)
