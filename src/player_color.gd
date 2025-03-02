class_name PlayerColor
extends RefCounted

static var colors: Array[PlayerColor] = [
	PlayerColor.make(Color(0.6, 0, 0.2, 1), Color(1, 0.5, 0.3, 1)),
	PlayerColor.make(Color(0.3, 0.3, 0.7, 1), Color(0.6, 0.85, 0.9, 1)),
	PlayerColor.make(Color(0.9, 0.7, 0, 1), Color(1, 0.95, 0.6, 1)),
	PlayerColor.make(Color(0, 0.4, 0, 1), Color(0.4, 0.8, 0.2, 1)),
]

var primary: Color
var secondary: Color


static func make(
	primary_color := Color.DIM_GRAY, secondary_color := Color.DARK_GRAY
) -> PlayerColor:
	var ret := PlayerColor.new()
	ret.primary = primary_color
	ret.secondary = secondary_color
	return ret


func equals(other: PlayerColor) -> bool:
	return primary == other.primary and secondary == other.secondary
