class_name UiPlayer
extends Control

var color := PlayerColor.new()
var animated := true


func set_color(value: PlayerColor) -> void:
	color = value
	$Robe.modulate = color.primary
	$Belt.modulate = color.secondary


func set_animated(value: bool) -> void:
	animated = value
	$Eyes.disable_animation = not animated
	$Robe.disable_animation = not animated
	$Belt.disable_animation = not animated
