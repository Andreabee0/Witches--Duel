@tool
extends Control

@export var texture: Texture2D:
	set(new_texture):
		texture = new_texture
		$MarginContainer/Texture.texture = texture

@export var selections := 0:
	set(new_selections):
		selections = new_selections
		var shader: ShaderMaterial = $Border.material
		shader.set_shader_parameter("color_count", selections)


func _ready() -> void:
	$MarginContainer/Texture.texture = texture
	var shader: ShaderMaterial = $Border.material
	shader.set_shader_parameter("color_count", selections)
