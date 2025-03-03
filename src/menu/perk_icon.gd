@tool
class_name PerkIcon
extends Control

@export var color := Color.WHITE:
	set = set_color

var selection := "":
	set = set_selection


func set_color(value: Color) -> void:
	color = value
	if not $Filling:
		return
	$Filling.modulate = color


func set_selection(value: String) -> void:
	if not value in PerkRegistry.all_perks:
		value = ""
	selection = value
	if not $Texture:
		return
	$Texture.visible = not selection.is_empty()
	if not selection.is_empty():
		$Texture.texture = PerkRegistry.get_perk_texture(selection)


func _ready() -> void:
	set_color(color)
	set_selection(selection)


func _get_property_list() -> Array[Dictionary]:
	return [
		{
			"name": "selection",
			"type": TYPE_STRING,
			"hint": PROPERTY_HINT_ENUM,
			"hint_string": ",".join(PerkRegistry.all_perks.keys())
		}
	]


func _property_can_revert(property: StringName) -> bool:
	if property == "selection":
		return true
	return false


func _property_get_revert(property: StringName) -> Variant:
	if property == "selection":
		return ""
	return null
