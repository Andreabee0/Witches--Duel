@tool
class_name SpellSelectMenu
extends Control

signal back_pressed
signal play_pressed

const BASE_PLAYER := preload("res://scenes/components/player_display.tscn")
const BASE_SELECTABLE := preload("res://scenes/components/cursor_selectable.tscn")

@export var player_count := 0:
	set = set_player_count

var player_displays: Array[PlayerSelections] = []
# player selectable to spell name
var spell_selectables := {}

@onready var spells_container: FlowContainer = $VerticalContainer/MainContainer/SpellsContainer
@onready var play_button: Button = $VerticalContainer/MainContainer/Navigation/PlayButton


func set_player_count(value: int) -> void:
	player_count = value
	Util.update_object_count(player_displays, player_count, make_player)


func make_player() -> Node:
	var ret := BASE_PLAYER.instantiate()
	$VerticalContainer/PlayersContainer.add_child(ret)
	var idx := player_displays.size()
	ret.perk_slots = 1
	if Engine.is_editor_hint():
		ret.spell_slots = 4
		ret.set_color(PlayerColor.make())
	else:
		var player := Players.joined_order[idx]
		ret.spell_slots = Players.get_stat(player, PlayerStats.SPELL_SLOTS)
		ret.set_color(Players.colors[player])
		ret.set_player_info(Players.info[player])
	return ret


func make_spell(spell: String) -> void:
	var child: CursorSelectable = BASE_SELECTABLE.instantiate()
	child.texture = SpellRegistry.get_spell_texture(spell)
	child.title = SpellRegistry.get_spell_title(spell)
	child.description = SpellRegistry.get_spell_description(spell)
	child.texture_color = Color.BLACK
	Util.checked_connect(child.on_button, _on_spell_button_pressed)
	spells_container.add_child(child)
	spell_selectables[child] = spell


func update_can_play() -> void:
	play_button.disabled = not Players.all_joined_selected_spells()


func update_spell_selectables(info: PlayerInfo) -> void:
	for selectable: CursorSelectable in spell_selectables:
		selectable.set_player_selected(
			info.device.device, info.has_spell(spell_selectables[selectable])
		)


func _ready() -> void:
	if Engine.is_editor_hint():
		set_player_count(player_count)
	else:
		for child in spells_container.get_children():
			child.queue_free()
		for spell in SpellRegistry.all_spells:
			make_spell(spell)
		set_player_count(Players.get_joined_count())
		for info in Players.info.values():
			update_spell_selectables(info)
		update_can_play()


func _on_back_pressed() -> void:
	for info: PlayerInfo in Players.info.values():
		info.spells.clear()
	back_pressed.emit()


func _on_play_pressed() -> void:
	play_pressed.emit()


func _on_spell_button_pressed(selectable: CursorSelectable, device: int, button: int) -> void:
	var info: PlayerInfo = Players.info[device]
	info.set_spell(button, SpellRegistry.new_spell_instance(spell_selectables[selectable]))
	update_spell_selectables(info)
	update_can_play()
