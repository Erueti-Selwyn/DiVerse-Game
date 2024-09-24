extends Control

var player1Character = 1
var player2Character = 1
var localPlayer1Controller = true
var localPlayer2Controller = true
@onready var global_script = $"/root/Global"
@onready var player1InputOption = $"MarginContainer/VBoxContainer/HBoxContainer3/Player1Input"
@onready var player2InputOption = $"MarginContainer/VBoxContainer/HBoxContainer3/Player2Input"

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Loaded")


func _on_player_1_input_item_selected(index):
	if index == 0:
		localPlayer1Controller = true
		print("Player 1 Controller")
	elif index == 1:
		localPlayer1Controller = false
		print("Player 1 Keyboard")

func _on_player_2_input_item_selected(index):
	if index == 0:
		localPlayer2Controller = true
		print("Player 2 Controller")
	elif index == 1:
		localPlayer2Controller = false
		print("Player 2 Keyboard")


func _on_start_pressed():
	if !global_script.player1Controller && !global_script.player2Controller:
		print("Cannot Have 2 Keyboards!")
	else:
		global_script.globalPlayerCharacter1 = player1Character
		global_script.globalPlayerCharacter2 = player2Character
		global_script.player1Controller = localPlayer1Controller
		global_script.player2Controller = localPlayer2Controller
		get_tree().change_scene_to_file("res://scenes/level.tscn")


func _on_exits_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")


func _on_african_button_1_pressed():
	player1Character = 1
	print("African 1")


func _on_chinese_button_1_pressed():
	player1Character = 2
	print("Chinese 1")

func _on_japanese_button_1_pressed():
	player1Character = 3
	print("Japanese 1")

func _on_samoan_button_1_pressed():
	player1Character = 4
	print("Samoan 1")

func _on_viking_button_1_pressed():
	player1Character = 5
	print("Viking 1")

func _on_mexican_button_1_pressed():
	player1Character = 6
	print("Mexican 1")

func _on_african_button_2_pressed():
	player2Character = 1
	print("African 2")

func _on_chinese_button_2_pressed():
	player2Character = 2
	print("Chinese 2")

func _on_japanese_button_2_pressed():
	player2Character = 3
	print("Japanese 2")

func _on_samoan_button_2_pressed():
	player2Character = 4
	print("Samoan 2")

func _on_viking_button_2_pressed():
	player2Character = 5
	print("Viking 2")

func _on_mexican_button_2_pressed():
	player2Character = 6
	print("Mexican 2")
