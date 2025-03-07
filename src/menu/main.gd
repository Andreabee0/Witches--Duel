class_name MainMenu
extends Control

signal play_pressed
signal options_pressed
signal quit_pressed


func _ready() -> void:
	$Buttons/Play.call_deferred("grab_focus")
	Util.checked_connect(Players.devices_changed, _on_devices_changed)
	_on_devices_changed()


func _exit_tree() -> void:
	Util.checked_disconnect(Players.devices_changed, _on_devices_changed)


func _on_devices_changed():
	$Buttons/Play.disabled = Players.get_device_count() < 1


func _on_quit_pressed() -> void:
	quit_pressed.emit()


func _on_play_pressed() -> void:
	play_pressed.emit()


func _on_options_pressed() -> void:
	options_pressed.emit()
