extends Node

signal devices_changed

# dictionary of joined player ids to their selections
var selections := {}
var devices: Array[DeviceInput]


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


func get_device_count():
	return devices.size() if Settings.include_keyboard else devices.size() - 1


func get_joined_count():
	return selections.size()
