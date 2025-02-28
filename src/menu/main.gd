class_name MainMenu
extends Control

signal play_pressed
signal options_pressed


func _on_quit_pressed():
	get_tree().quit()


func _on_play_pressed():
	play_pressed.emit()


func _on_options_pressed():
	options_pressed.emit()
