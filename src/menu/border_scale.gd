@tool
extends ColorRect


func _ready() -> void:
	if not Engine.is_editor_hint():
		material = material.duplicate()


func _process(_delta: float) -> void:
	if not Engine.is_editor_hint():
		var shader: ShaderMaterial = material
		shader.set_shader_parameter("scale", size)
