extends Control

@onready var global_script = $"/root/Global"
@onready var player1CharacterOption = $"MarginContainer/VBoxContainer/HBoxContainer/Player1Character"
@onready var player2CharacterOption = $"MarginContainer/VBoxContainer/HBoxContainer/Player2Character"
@onready var player1InputOption = $"MarginContainer/VBoxContainer/HBoxContainer3/Player1Input"
@onready var player2InputOption = $"MarginContainer/VBoxContainer/HBoxContainer3/Player2Input"

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Loaded")

func _on_player_1_character_item_selected(index):
	if index == 0:
		global_script.globalPlayerCharacter1 = 0
	elif index == 1:
		global_script.globalPlayerCharacter1 = 1
	elif index == 2:
		global_script.globalPlayerCharacter1 = 2
	elif index == 3:
		global_script.globalPlayerCharacter1 = 3
	elif index == 4:
		global_script.globalPlayerCharacter1 = 4
	elif index == 5:
		global_script.globalPlayerCharacter1 = 5


func _on_player_2_character_item_selected(index):
	if index == 0:
		global_script.globalPlayerCharacter2 = 0
	elif index == 1:
		global_script.globalPlayerCharacter2 = 1
	elif index == 2:
		global_script.globalPlayerCharacter2 = 2
	elif index == 3:
		global_script.globalPlayerCharacter2 = 3
	elif index == 4:
		global_script.globalPlayerCharacter2 = 4
	elif index == 5:
		global_script.globalPlayerCharacter2 = 5


func _on_player_1_input_item_selected(index):
	if index == 0:
		global_script.player1Controller = true
	elif index == 1:
		global_script.player1Controller = false

func _on_player_2_input_item_selected(index):
	if index == 0:
		global_script.player2Controller = true
	elif index == 1:
		global_script.player1Controller = false


func _on_start_pressed():
	if !global_script.player1Controller && !global_script.player2Controller:
		print("Cannot Have 2 Keyboards!")
	else:
		get_tree().change_scene_to_file("res://scenes/level.tscn")


func _on_exits_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
