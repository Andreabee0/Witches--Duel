@tool
extends Node

var all_spells := {
	AirSpell.name: [AirSpell, preload("res://sprites/symbols/air.png")],
	AntimonySpell.name: [AntimonySpell, preload("res://sprites/symbols/antimony.png")],
	ArsenicSpell.name: [ArsenicSpell, preload("res://sprites/symbols/arsenic.png")],
	BismuthSpell.name: [BismuthSpell, preload("res://sprites/symbols/bismuth.png")],
	BloodSpell.name: [BloodSpell, preload("res://sprites/symbols/blood.png")],
	CopperSpell.name: [CopperSpell, preload("res://sprites/symbols/copper.png")],
	EarthSpell.name: [EarthSpell, preload("res://sprites/symbols/earth.png")],
	EggshellsSpell.name: [EggshellsSpell, preload("res://sprites/symbols/eggshells.png")],
	FireSpell.name: [FireSpell, preload("res://sprites/symbols/fire.png")],
	GlassSpell.name: [GlassSpell, preload("res://sprites/symbols/glass.png")],
	GoldSpell.name: [GoldSpell, preload("res://sprites/symbols/sun.png")],
	IronSpell.name: [IronSpell, preload("res://sprites/symbols/iron.png")],
	LeadSpell.name: [LeadSpell, preload("res://sprites/symbols/lead.png")],
	MercurySpell.name: [MercurySpell, preload("res://sprites/symbols/mercury.png")],
	PlatinumSpell.name: [PlatinumSpell, preload("res://sprites/symbols/platinum.png")],
	SaltSpell.name: [SaltSpell, preload("res://sprites/symbols/salt.png")],
	SilverSpell.name: [SilverSpell, preload("res://sprites/symbols/silver.png")],
	SulfurSpell.name: [SulfurSpell, preload("res://sprites/symbols/sulfur.png")],
	TinSpell.name: [TinSpell, preload("res://sprites/symbols/tin.png")],
	WaterSpell.name: [WaterSpell, preload("res://sprites/symbols/water.png")],
	ZincSpell.name: [ZincSpell, preload("res://sprites/symbols/zinc.png")],
}


func new_spell_instance(spell: String) -> BaseSpell:
	return all_spells[spell][0].new()


func get_spell_texture(spell: String) -> Texture2D:
	return all_spells[spell][1]


func get_spell_title(spell: String) -> String:
	return all_spells[spell][0].title


func get_spell_description(spell: String) -> String:
	return all_spells[spell][0].description
