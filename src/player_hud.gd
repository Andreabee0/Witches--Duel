@tool
class_name PlayerHud
extends Control

const BASE_BAR := preload("res://scenes/components/icon_progress.tscn")

@export var border_color := Color.DIM_GRAY:
	set = set_border_color

@export var bars_color := Color.DARK_GRAY:
	set = set_bars_color

var player_info: PlayerInfo
var bars: Array[IconProgress] = []
var spells: Array[BaseSpell] = []

@onready var health: IconProgress = $Margin/Container/Health
@onready var bar_container := $Margin/Container


func set_border_color(value: Color) -> void:
	border_color = value
	$Border.material.set_shader_parameter("colors", [border_color])


func set_bars_color(value: Color) -> void:
	bars_color = value
	for bar in bars:
		bar.color = border_color


func set_spells(value: Array) -> void:
	spells = value
	Util.update_object_count(bars, spells.size(), make_bar)


func set_player(player: int) -> void:
	player_info = Players.info[player]
	var spell_array_gdscript_bad: Array[BaseSpell] = []
	spell_array_gdscript_bad.assign(player_info.spells.values())
	set_border_color(Players.colors[player].primary)
	set_bars_color(Players.colors[player].secondary)
	set_spells(spell_array_gdscript_bad)


func make_bar() -> IconProgress:
	var instance: IconProgress = BASE_BAR.instantiate()
	bar_container.add_child(instance)
	var spell := spells[bars.size()]
	instance.texture = SpellRegistry.get_spell_texture(spell.name)
	instance.color = bars_color
	return instance


func _ready() -> void:
	set_border_color(border_color)
	set_bars_color(bars_color)


func _process(_delta: float) -> void:
	if Engine.is_editor_hint() or not player_info:
		return
	var max_health := player_info.get_stat(PlayerStats.HEALTH)
	health.max_value = max_health
	health.fill = max_health - player_info.damage_taken
	for i in bars.size():
		var spell := spells[i]
		var normalized := spell.get_remaining_cooldown() / spell.get_modified_cooldown()
		bars[i].set_normalized_fill(1 - normalized)
