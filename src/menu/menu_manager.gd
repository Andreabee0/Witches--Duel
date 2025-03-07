extends Node

const MAIN_MENU := preload("res://scenes/menu/main.tscn")
const OPTIONS_MENU := preload("res://scenes/menu/options.tscn")
const PERK_SELECT_MENU := preload("res://scenes/menu/perk_select.tscn")
const SPELL_SELECT_MENU := preload("res://scenes/menu/spell_select.tscn")
const GAME := preload("res://scenes/dungeon.tscn")
const VICTORY_MENU := preload("res://scenes/menu/victory.tscn")


func _ready() -> void:
	if GlobalInfo.battle_ended:
		set_menu_victory()
	else:
		set_menu_main()


func clear_menus() -> void:
	for child in $Wrapper.get_children():
		child.queue_free()


func set_menu(menu: PackedScene) -> Node:
	clear_menus()
	var inst = menu.instantiate()
	$Wrapper.add_child(inst)
	return inst


func start_game() -> void:
	get_tree().change_scene_to_packed(GAME)


func exit() -> void:
	await get_tree().create_timer(0.5).timeout
	get_tree().quit()


func set_menu_main() -> void:
	var menu: MainMenu = set_menu(MAIN_MENU)
	Util.checked_connect(menu.play_pressed, set_menu_perk_select)
	Util.checked_connect(menu.options_pressed, set_menu_options)
	Util.checked_connect(menu.quit_pressed, exit)


func set_menu_perk_select() -> void:
	var menu: PerkSelectMenu = set_menu(PERK_SELECT_MENU)
	Util.checked_connect(menu.back_pressed, set_menu_main)
	Util.checked_connect(menu.forward_pressed, set_menu_spell_select)


func set_menu_spell_select() -> void:
	var menu: SpellSelectMenu = set_menu(SPELL_SELECT_MENU)
	Util.checked_connect(menu.back_pressed, set_menu_perk_select)
	Util.checked_connect(menu.play_pressed, start_game)


func set_menu_options() -> void:
	var menu: OptionsMenu = set_menu(OPTIONS_MENU)
	Util.checked_connect(menu.back_pressed, set_menu_main)


func set_menu_victory() -> void:
	var menu: VictoryMenu = set_menu(VICTORY_MENU)
	Util.checked_connect(menu.home_pressed, set_menu_main)
	Util.checked_connect(menu.replay_pressed, set_menu_perk_select)
	Util.checked_connect(menu.quit_pressed, exit)
