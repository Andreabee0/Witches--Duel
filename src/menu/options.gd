class_name OptionsMenu
extends Control

signal back_pressed

@onready
var volume_slider: HSlider = $MainContainer/MarginContainer/VBoxContainer/VolumeSlider/Layout/Slider
@onready
var keyboard_toggle: CheckButton = $MainContainer/MarginContainer/VBoxContainer/KeyboardToggle


func _ready() -> void:
	volume_slider.set_value_no_signal(Settings.volume)
	keyboard_toggle.set_pressed_no_signal(Settings.include_keyboard)
	$MainContainer/BackButton.call_deferred("grab_focus")


func _on_back_pressed():
	back_pressed.emit()


func _on_volume_changed(value: float):
	Settings.volume = value


func _on_keyboard_toggled(value: bool):
	Settings.include_keyboard = value
