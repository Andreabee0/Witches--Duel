@tool
class_name IconProgress
extends HBoxContainer

@export var color := Color.WHITE:
	set = set_color

@export var texture: Texture2D:
	set = set_texture

@export var fill := 0.0:
	set = set_fill

@export var max_value := 10000.0:
	set = set_max_value

@export var const_bar_color := false
@export var bar_color := Color.WHITE

@onready var icon := $Icon
@onready var bar := $ProgressBar


func set_color(value: Color) -> void:
	color = value
	if icon:
		icon.modulate = color


func set_texture(value: Texture2D) -> void:
	texture = value
	if icon:
		icon.texture = texture


func set_fill(value: float) -> void:
	fill = clampf(value, 0, max_value)
	if bar:
		bar.value = int(fill)


func set_max_value(value: float) -> void:
	max_value = value
	if bar:
		bar.max_value = max_value


func set_normalized_fill(value: float) -> void:
	value = clampf(value, 0, 1)
	set_fill(value * max_value)


func _ready() -> void:
	set_color(color)
	set_texture(texture)
	set_fill(fill)
	set_max_value(max_value)
	Util.checked_connect(bar.value_changed, _on_value_change)


func _on_value_change(value: float) -> void:
	if const_bar_color:
		bar.modulate = bar_color
	else:
		var normalized := value / max_value
		if normalized < 0.5:
			bar.modulate = Color.ORANGE_RED.lerp(Color.WHITE, normalized * 2)
		else:
			bar.modulate = Color.WHITE.lerp(Color.FOREST_GREEN, normalized * 2 - 1)
