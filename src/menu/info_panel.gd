@tool
class_name InfoPanel
extends PanelContainer

@export var title := "":
	set = set_title

@export var description := "":
	set = set_description


func set_title(value: String):
	title = value
	$MainContainer/Title.text = title


func set_description(value: String):
	description = value
	$MainContainer/Description.text = description


func _ready() -> void:
	set_title(title)
	set_description(description)
