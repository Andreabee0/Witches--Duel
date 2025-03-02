@tool
extends Control

signal on_pressed(device: int)

@export var texture: Texture2D:
	set = set_texture

@export var color_count := 0:
	set = set_color_count

@export var colors: Array[Color] = []:
	set = set_colors

# device id to color index
var players := {}


func set_texture(value: Texture2D) -> void:
	texture = value
	$MarginContainer/Texture.texture = texture


func set_color_count(value: int) -> void:
	color_count = value
	var shader: ShaderMaterial = $Border.material
	shader.set_shader_parameter("color_count", color_count)


func set_colors(value: Array[Color]) -> void:
	colors = value
	var shader: ShaderMaterial = $Border.material
	shader.set_shader_parameter("colors", colors)


func set_player_selected(player: int, select: bool) -> void:
	if select and not players.has(player):
		players[player] = color_count
		colors.append(Players.colors[player])
		set_colors(colors)
		set_color_count(players.size())
	elif not select and players.has(player):
		colors.remove_at(players[player])
		players.erase(player)
		set_color_count(players.size())
		set_colors(colors)


func _ready() -> void:
	set_texture(texture)
	set_color_count(color_count)
	set_colors(colors)


func _process(_delta: float) -> void:
	if not Engine.is_editor_hint():
		for device_id in Players.selections:
			var selections: Selections = Players.selections[device_id]
			if (
				get_global_rect().has_point(selections.cursor_position)
				and selections.device.is_action_just_released("ui_accept")
			):
				set_player_selected(device_id, not players.has(device_id))
				on_pressed.emit(device_id)
