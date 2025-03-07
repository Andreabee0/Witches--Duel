@tool
class_name CursorSelectable
extends Control

signal on_pressed(selectable: CursorSelectable, device: int)
signal on_button(selectable: CursorSelectable, device: int, button: int)

@export var select_sound: AudioStream = preload("res://sounds/select.wav")

@export var texture: Texture2D:
	set = set_texture

@export var color_count := 0:
	set = set_color_count

@export var colors: Array[Color] = []:
	set = set_colors

@export var title := "":
	set = set_title

@export var description := "":
	set = set_description

# device id to color index
var players := {}

@onready var info_panel: InfoPanel = $Info


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


func set_title(value: String):
	title = value
	if info_panel:
		info_panel.title = title


func set_description(value: String):
	description = value
	if info_panel:
		info_panel.description = description


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
	set_title(title)
	set_description(description)


func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		return
	var first_cursor_pos := Vector2.INF
	for device_id in Players.info:
		var player_info: PlayerInfo = Players.info[device_id]
		if player_info.cursor_in(get_global_rect()):
			if not first_cursor_pos.is_finite():
				first_cursor_pos = player_info.cursor_position
			var any_select := false
			if player_info.has_pressed():
				if not device_id in players:
					any_select = true
				on_pressed.emit(self, device_id)
			for button in player_info.buttons_has_pressed():
				if not device_id in players:
					any_select = true
				on_button.emit(self, device_id, button)
			if any_select:
				SoundPlayer.play_sound(select_sound)
	if first_cursor_pos.is_finite():
		info_panel.visible = true
		info_panel.global_position = first_cursor_pos
	else:
		info_panel.visible = false
