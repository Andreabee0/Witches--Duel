@tool
extends Node

static var perk_sheet := preload("res://sprites/perks.png")

var all_perks := {
	"chariot": [ChariotPerk, get_sheet_perk(7)],
	"devil": [DevilPerk, get_sheet_perk(3)], # 15
	"fool": [FoolPerk, get_sheet_perk(0)],
	"lovers": [LoversPerk, get_sheet_perk(6)],
	"magician": [MagicianPerk, get_sheet_perk(1)],
	"moon": [MoonPerk, get_sheet_perk(4)], # 18
	"sun": [SunPerk, get_sheet_perk(5)], # 19
	"temperance": [TemperancePerk, get_sheet_perk(8)], # 14
	"wheel_of_fortune": [WheelOfFortunePerk, get_sheet_perk(10)],
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
