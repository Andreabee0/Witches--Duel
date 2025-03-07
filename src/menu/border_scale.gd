@tool
extends ColorRect


@export var scale_in_editor := false


func update_scale() -> void:
	var shader: ShaderMaterial = material
	shader.set_shader_parameter("scale", size)


func _ready() -> void:
	if not Engine.is_editor_hint():
		material = material.duplicate()


func _process(_delta: float) -> void:
	if not Engine.is_editor_hint() or Engine.is_editor_hint() and scale_in_editor:
		update_scale()
