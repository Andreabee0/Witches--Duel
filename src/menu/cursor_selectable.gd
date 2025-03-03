@tool
class_name CursorSelectable
extends Control

signal on_pressed(selectable: CursorSelectable, device: int)

@export var select_sound: AudioStream = preload("res://sounds/select.wav")

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
		colors.append(Players.colors[player].secondary)
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
			if selections.cursor_in(get_global_rect()) and selections.has_pressed():
				if not device_id in players:
					SoundPlayer.play_sound(select_sound)
				on_pressed.emit(self, device_id)
