extends Control

@onready var global_script = $"/root/Global"
@onready var optionPlayerButton1 = $"MarginContainerPlayer1/VBoxContainer/OptionButtonPlayer1"
@onready var optionPlayerButton2 = $"MarginContainerPlayer2/VBoxContainer/OptionButtonPlayer2"

func _ready():
	print("Loaded")
	if global_script.player1Controller == true:
		optionPlayerButton1.select(0)
	else:
		optionPlayerButton1.select(1)
	if global_script.player2Controller == true:
		optionPlayerButton2.select(0)
	else:
		optionPlayerButton2.select(1)

func _on_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func _on_option_button_player_1_item_selected(input_type):
	if input_type == 0:
		global_script.player1Controller = true
	elif input_type == 1:
		global_script.player1Controller = false


func _on_option_button_player_2_item_selected(input_type):
	if input_type == 0:
		Global.player2Controller = true
	elif input_type == 1:
		Global.player2Controller = false


