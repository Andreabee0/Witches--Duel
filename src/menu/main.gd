class_name MainMenu
extends Control

signal play_pressed
signal options_pressed


func _ready() -> void:
	$Buttons/Play.call_deferred("grab_focus")


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_play_pressed() -> void:
	play_pressed.emit()


func _on_options_pressed() -> void:
	options_pressed.emit()
