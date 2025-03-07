class_name OptionsMenu
extends Control

signal back_pressed

@onready
var volume_slider: HSlider = $MainContainer/MarginContainer/VBoxContainer/VolumeSlider/Layout/Slider
@onready
var keyboard_toggle: CheckButton = $MainContainer/MarginContainer/VBoxContainer/KeyboardToggle


func _ready() -> void:
	volume_slider.set_value_no_signal(GlobalInfo.volume)
	keyboard_toggle.set_pressed_no_signal(GlobalInfo.include_keyboard)
	$MainContainer/BackButton.call_deferred("grab_focus")


func _on_back_pressed() -> void:
	back_pressed.emit()


func _on_volume_changed(value: float) -> void:
	GlobalInfo.volume = value


func _on_keyboard_toggled(value: bool) -> void:
	GlobalInfo.include_keyboard = value
