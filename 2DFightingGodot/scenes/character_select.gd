extends Control

var player1Character = 1
var player2Character = 1

@onready var global_script = $"/root/Global"
@onready var player1InputOption = $"MarginContainer/VBoxContainer/HBoxContainer3/Player1Input"
@onready var player2InputOption = $"MarginContainer/VBoxContainer/HBoxContainer3/Player2Input"

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Loaded")


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

	global_script.globalPlayerCharacter1 = player1Character
	global_script.globalPlayerCharacter2 = player2Character
	global_script.player1Controller = localPlayer1Controller
	global_script.player2Controller = localPlayer2Controller
	get_tree().change_scene_to_file("res://scenes/Level.tscn")



func _on_african_button_1_pressed():
	player1Character = 1


func _on_chinese_button_1_pressed():
	player1Character = 2


func _on_japanese_button_1_pressed():
	player1Character = 3


func _on_samoan_button_1_pressed():
	player1Character = 4


func _on_viking_button_1_pressed():
	player1Character = 5


func _on_mexican_button_1_pressed():
	player1Character = 6


func _on_african_button_2_pressed():
	player2Character = 1


func _on_chinese_button_2_pressed():
	player2Character = 2


func _on_japanese_button_2_pressed():
	player2Character = 3


func _on_samoan_button_2_pressed():
	player2Character = 4


func _on_viking_button_2_pressed():
	player2Character = 5


func _on_mexican_button_2_pressed():
	player2Character = 6
