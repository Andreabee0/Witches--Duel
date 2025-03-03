extends Node

signal devices_changed
signal joined_devices_changed

var join_sound := preload("res://sounds/connect.wav")
var leave_sound := preload("res://sounds/disconnect.wav")

var devices: Array[DeviceInput]
# device ids of joined players
var joined_order: Array[int] = []
# dictionary of devices to their selections
var selections := {}
# dictionary of devices to their colors
var colors := {}


func _init() -> void:
	Input.joy_connection_changed.connect(_on_joy_connection_changed)
	# put keyboard player always at start of list
	devices = [DeviceInput.new(-1)]


func _on_joy_connection_changed(device: int, connected: bool) -> void:
	if connected:
		devices.append(DeviceInput.new(device))
	else:
		var idx := -1
		for i in devices.size():
			if devices[i].device == device:
				idx = i
				break
		if idx >= 0:
			devices.remove_at(idx)
	devices_changed.emit()


func next_color() -> PlayerColor:
	for color in PlayerColor.colors:
		var present := false
		for key in colors:
			if colors[key].equals(color):
				present = true
				break
		if not present:
			return color
	return PlayerColor.colors[0]


func get_device_count() -> int:
	return devices.size() if Settings.include_keyboard else devices.size() - 1


func get_device_at(index: int) -> DeviceInput:
	return devices[index] if Settings.include_keyboard else devices[index + 1]


func listen_for_joins() -> void:
	var changed := false
	for device in devices:
		if device.is_keyboard() and not Settings.include_keyboard:
			continue
		if device.device in selections:
			if device.is_action_just_released("multi_ui_cancel"):
				print("device ", device.device, " left")
				SoundPlayer.play_sound(leave_sound)
				joined_order.erase(device.device)
				selections.erase(device.device)
				colors.erase(device.device)
				changed = true
		else:
			if device.is_action_just_pressed("multi_ui_accept"):
				print("device ", device.device, " joined")
				SoundPlayer.play_sound(join_sound)
				joined_order.append(device.device)
				selections[device.device] = Selections.new(device)
				colors[device.device] = next_color()
				changed = true
	if changed:
		joined_devices_changed.emit()


func unjoin_all(emit := true) -> void:
	selections = {}
	colors = {}
	if emit:
		joined_devices_changed.emit()


func get_joined_count() -> int:
	return selections.size()


func is_device_joined(device: DeviceInput) -> bool:
	return selections.has(device.device)


func get_selections_for_joined(device: DeviceInput) -> Selections:
	return selections[device.device]


func get_color_for_joined(device: DeviceInput) -> PlayerColor:
	return colors[device.device]


func all_joined_selected_perk() -> bool:
	for key in selections:
		if not selections[key].has_perk():
			return false
	return true
