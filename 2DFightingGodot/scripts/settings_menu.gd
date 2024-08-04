extends Control

@onready var global_script = $"/root/Global"

func _on_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func _on_option_button_player_1_item_selected(input_type):
	if input_type == 0:
		print("controller")
		global_script.player1Controller = true
	elif input_type == 1:
		print("keyboard")
		global_script.player1Controller = false


func _on_option_button_player_2_item_selected(input_type):
	if input_type == 0:
		print("controller")
		Global.player2Controller = true
	elif input_type == 1:
		print("keyboard")
		Global.player2Controller = false


