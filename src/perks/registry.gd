@tool
extends Node

static var perk_sheet := preload("res://sprites/perks.png")

var all_perks := {
	ChariotPerk.name: [ChariotPerk, get_sheet_perk(7)],
	DevilPerk.name: [DevilPerk, get_sheet_perk(3)], # 15
	FoolPerk.name: [FoolPerk, get_sheet_perk(0)],
	LoversPerk.name: [LoversPerk, get_sheet_perk(6)],
	MagicianPerk.name: [MagicianPerk, get_sheet_perk(1)],
	MoonPerk.name: [MoonPerk, get_sheet_perk(4)], # 18
	SunPerk.name: [SunPerk, get_sheet_perk(5)], # 19
	TemperancePerk.name: [TemperancePerk, get_sheet_perk(8)], # 14
	WheelOfFortunePerk.name: [WheelOfFortunePerk, get_sheet_perk(10)],
}


static func get_sheet_perk(index: int) -> Texture2D:
	var dims := Vector2(16, 26)
	var width := int(perk_sheet.get_width() / dims.x)
	var atlas := AtlasTexture.new()
	atlas.atlas = perk_sheet
	atlas.region.size = dims
	var y_pos := int(index / float(width))
	var x_pos = index - y_pos * width
	atlas.region.position = Vector2(dims.x * x_pos, dims.y * y_pos)
	return atlas


func new_perk_instance(perk: String) -> BasePerk:
	return all_perks[perk][0].new()


func get_perk_texture(perk: String) -> Texture2D:
	return all_perks[perk][1]
