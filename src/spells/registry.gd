@tool
extends Node

var all_spells := {
	"iron": [IronSpell, preload("res://sprites/symbols/iron.png")],
	"lead": [LeadSpell, preload("res://sprites/symbols/lead.png")],
	"sulfur": [SulfurSpell, preload("res://sprites/symbols/sulfur.png")],
}


func new_spell_instance(spell: String) -> BaseSpell:
	return all_spells[spell][0].new()


func get_spell_texture(spell: String) -> Texture2D:
	return all_spells[spell][1]
