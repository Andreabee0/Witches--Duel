@tool
class_name SpellIcon
extends Control

@export var button := -1:
	set = set_button

@export var color := Color.WHITE:
	set = set_color


func set_button(value: int) -> void:
	button = clamp(value, -1, Selections.button_textures.size())
	var enabled := button >= 0
	$Filling.visible = enabled
	$Button.visible = enabled
	$Symbol.visible = false
	if enabled:
		$Button.texture = Selections.button_textures[button]


func set_symbol(spell: String):
	$Filling.visible = true
	$Button.visible = false
	$Symbol.visible = true
	$Symbol.texture = SpellRegistry.get_spell_texture(spell)


func set_color(value: Color) -> void:
	color = value
	$Filling.modulate = color


func _ready() -> void:
	set_color(color)
	set_button(button)
