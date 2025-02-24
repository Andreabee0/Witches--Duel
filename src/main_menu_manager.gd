extends Control

func _on_quit_button_down():
    get_tree().quit()

func _on_play_button_down():
    get_tree().change_scene_to_file("res://scenes/spell_select_menu.tscn")
func _on_options_button_down():
    get_tree().change_scene_to_file("res://scenes/options.tscn")