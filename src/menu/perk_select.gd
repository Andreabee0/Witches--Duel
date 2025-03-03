@tool
class_name PerkSelectMenu
extends Control

signal back_pressed

const BASE_PLAYER := preload("res://scenes/components/player_display.tscn")
const BASE_SELECTABLE := preload("res://scenes/components/player_selectable.tscn")

@export var player_count := 0:
	set = set_player_count

var player_displays: Array[PlayerSelections] = []
# player selectable to perk name
var perk_selectables := {}

@onready var perks_container = $VerticalContainer/MainContainer/PerksContainer


func set_player_count(value: int) -> void:
	player_count = value
	Util.update_object_count(player_displays, player_count, make_player)


func make_player() -> Node:
	var ret: PlayerSelections = BASE_PLAYER.instantiate()
	$VerticalContainer/PlayersContainer.add_child(ret)
	ret.spell_slots = 0
	ret.perk_slots = 1 if Engine.is_editor_hint() else 0
	ret.set_color(PlayerColor.make())
	return ret


func update_player_count() -> void:
	set_player_count(Players.get_device_count())
	updated_joined_players()


func updated_joined_players() -> void:
	for i in Players.get_device_count():
		var device := Players.get_device_at(i)
		var display := player_displays[i]
		if Players.is_device_joined(device):
			display.set_color(Players.get_color_for_joined(device))
			display.perk_slots = 1
			display.set_selections(Players.get_selections_for_joined(device))
		else:
			for perk: PlayerSelectable in perks_container.get_children():
				perk.set_player_selected(display.get_device(), false)
			display.set_color(PlayerColor.make())
			display.perk_slots = 0
			display.set_selections(null)


func _ready() -> void:
	for child in perks_container.get_children():
		child.queue_free()
	for perk in PerkRegistry.all_perks:
		var child: PlayerSelectable = BASE_SELECTABLE.instantiate()
		child.texture = PerkRegistry.get_perk_texture(perk)
		Util.checked_connect(child.on_pressed, _on_perk_selected)
		perks_container.add_child(child)
		perk_selectables[child] = perk

	if Engine.is_editor_hint():
		set_player_count(player_count)
	else:
		update_player_count()
		Util.checked_connect(Players.devices_changed, update_player_count)
		Util.checked_connect(Players.joined_devices_changed, updated_joined_players)


func _process(_delta: float) -> void:
	if not Engine.is_editor_hint():
		Players.listen_for_joins()


func _exit_tree() -> void:
	Util.checked_disconnect(Players.devices_changed, update_player_count)
	Util.checked_disconnect(Players.joined_devices_changed, updated_joined_players)


func _on_back_pressed() -> void:
	Players.unjoin_all(false)
	back_pressed.emit()


func _on_perk_selected(selectable: PlayerSelectable, device: int) -> void:
	for other: PlayerSelectable in perk_selectables:
		if other == selectable:
			continue
		other.set_player_selected(device, false)
	selectable.set_player_selected(device, true)
	var selections: Selections = Players.selections[device]
	selections.set_perk(PerkRegistry.new_perk_instance(perk_selectables[selectable]))
