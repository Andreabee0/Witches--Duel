@tool
extends Control

@export var texture: Texture2D:
	set = set_texture

@export var selections := 0:
	set = set_selections


func set_texture(value: Texture2D):
	texture = value
	$MarginContainer/Texture.texture = texture


func set_selections(value: int):
	selections = value
	var shader: ShaderMaterial = $Border.material
	shader.set_shader_parameter("color_count", selections)


func _ready() -> void:
	set_texture(texture)
	set_selections(selections)
