@tool
extends ColorRect


func _ready() -> void:
	material = material.duplicate()


func _process(_delta: float) -> void:
	var shader: ShaderMaterial = material
	shader.set_shader_parameter("scale", size)
