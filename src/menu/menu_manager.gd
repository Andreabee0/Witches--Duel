extends Node

var main_menu := preload("res://scenes/menu/main.tscn")
var options_menu := preload("res://scenes/menu/options.tscn")
var perk_select_menu := preload("res://scenes/menu/perk_select.tscn")
var spell_select_menu := preload("res://scenes/menu/spell_select.tscn")


func _ready() -> void:
	set_menu_main()


func clear_menus() -> void:
	for child in $Wrapper.get_children():
		child.queue_free()


func set_menu(menu: PackedScene) -> Node:
	clear_menus()
	var inst = menu.instantiate()
	$Wrapper.add_child(inst)
	return inst


func set_menu_main() -> void:
	var menu: MainMenu = set_menu(main_menu)
	Util.checked_connect(menu.play_pressed, set_menu_perk_select)
	Util.checked_connect(menu.options_pressed, set_menu_options)


func set_menu_perk_select() -> void:
	var menu: PerkSelectMenu = set_menu(perk_select_menu)
	Util.checked_connect(menu.back_pressed, set_menu_main)
	Util.checked_connect(menu.forward_pressed, set_menu_spell_select)


func set_menu_spell_select() -> void:
	var menu: SpellSelectMenu = set_menu(spell_select_menu)
	Util.checked_connect(menu.back_pressed, set_menu_perk_select)


func set_menu_options() -> void:
	var menu: OptionsMenu = set_menu(options_menu)
	Util.checked_connect(menu.back_pressed, set_menu_main)
