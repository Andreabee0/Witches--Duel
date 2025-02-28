class_name OptionsMenu
extends Control

signal back_pressed

@onready
var volume_slider: HSlider = $VBoxContainer/MarginContainer/VBoxContainer/VolumeSlider/Layout/Slider
@onready
var keyboard_toggle: CheckButton = $VBoxContainer/MarginContainer/VBoxContainer/KeyboardToggle


func _ready() -> void:
	volume_slider.value = Settings.volume
	keyboard_toggle.button_pressed = Settings.include_keyboard


func _on_back_pressed():
	back_pressed.emit()


func _on_volume_changed(value: float):
	Settings.volume = value


func _on_keyboard_toggled(value: bool):
	Settings.include_keyboard = value
