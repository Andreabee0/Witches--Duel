@tool
class_name PlayerSelections
extends Container

const BASE_PERK_SLOT := preload("res://scenes/components/perk_icon.tscn")
const BASE_SPELL_SLOT := preload("res://scenes/components/spell_icon.tscn")

@export var color := Color.WHITE:
	set = set_color

@export var spell_slots := 0:
	set = set_spell_slots

@export var perk_slots := 0:
	set = set_perk_slots

var slots: Array[Node] = []
var perk: Array[Node] = []


func set_color(value: Color) -> void:
	color = value
	for slot in slots:
		slot.color = color
	for p in perk:
		p.color = color


func set_spell_slots(value) -> void:
	spell_slots = clamp(value, 0, 4)
	VariableObjects.update_object_count(slots, spell_slots, make_spell_slot)


func set_perk_slots(value) -> void:
	perk_slots = clamp(value, 0, 1)
	VariableObjects.update_object_count(perk, perk_slots, make_perk_slot)


func make_spell_slot() -> Node:
	var ret := BASE_SPELL_SLOT.instantiate()
	$Margin/MainContainer/SpellsContainer.add_child(ret)
	ret.color = color
	return ret


func make_perk_slot() -> Node:
	var ret := BASE_PERK_SLOT.instantiate()
	$Margin/MainContainer/PerkContainer.add_child(ret)
	ret.color = color
	return ret


func _ready() -> void:
	set_color(color)
	set_perk_slots(perk_slots)
	set_spell_slots(spell_slots)
