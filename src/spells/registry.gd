@tool
extends Node

var all_spells := {
	IronSpell.name: [IronSpell, preload("res://sprites/symbols/iron.png")],
	LeadSpell.name: [LeadSpell, preload("res://sprites/symbols/lead.png")],
	SulfurSpell.name: [SulfurSpell, preload("res://sprites/symbols/sulfur.png")],
	GlassSpell.name: [GlassSpell, preload("res://sprites/symbols/glass.png")],
}


func new_spell_instance(spell: String) -> BaseSpell:
	return all_spells[spell][0].new()


func get_spell_texture(spell: String) -> Texture2D:
	return all_spells[spell][1]
