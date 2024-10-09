extends Control

const controllerIconOff = preload("res://assets/Ui Assets/ControllerButtonOffFinal.png")
const controllerIconOn = preload("res://assets/Ui Assets/ControllerButtonOnFinal.png")
const keyboardIconOff = preload("res://assets/Ui Assets/MouseButtonOffFinal.png")
const keyboardIconOn = preload("res://assets/Ui Assets/MouseButtonOnFinal.png")

var player1Character = 1
var player2Character = 1
var localPlayer1Controller = true
var localPlayer2Controller = true
@onready var global_script = $"/root/Global"
@onready var keyboardPlayer1Button = $MarginContainer/VBoxContainer/HBoxContainer3/HBoxContainer/KeyboardPlayer1
@onready var controllerPlayer1Button = $MarginContainer/VBoxContainer/HBoxContainer3/HBoxContainer/ControllerPlayer1
@onready var keyboardPlayer2Button = $MarginContainer/VBoxContainer/HBoxContainer3/HBoxContainer2/KeyboardPlayer2
@onready var controllerPlayer2Button = $MarginContainer/VBoxContainer/HBoxContainer3/HBoxContainer2/ControllerPlayer2
@onready var africanButton1 = $MarginContainer/VBoxContainer/HBoxContainerCharacterSelect/VBoxContainer/HBoxContainer/AfricanButton1
@onready var chineseButton1 = $MarginContainer/VBoxContainer/HBoxContainerCharacterSelect/VBoxContainer/HBoxContainer/ChineseButton1
@onready var japaneseButton1 = $MarginContainer/VBoxContainer/HBoxContainerCharacterSelect/VBoxContainer/HBoxContainer/JapaneseButton1
@onready var samoanButton1 = $MarginContainer/VBoxContainer/HBoxContainerCharacterSelect/VBoxContainer/HBoxContainer2/SamoanButton1
@onready var vikingButton1 = $MarginContainer/VBoxContainer/HBoxContainerCharacterSelect/VBoxContainer/HBoxContainer2/VikingButton1
@onready var mexicanButton1 = $MarginContainer/VBoxContainer/HBoxContainerCharacterSelect/VBoxContainer/HBoxContainer2/MexicanButton1
@onready var africanButton2 = $MarginContainer/VBoxContainer/HBoxContainerCharacterSelect/VBoxContainer2/HBoxContainer/AfricanButton2
@onready var chineseButton2 = $MarginContainer/VBoxContainer/HBoxContainerCharacterSelect/VBoxContainer2/HBoxContainer/ChineseButton2
@onready var japaneseButton2 = $MarginContainer/VBoxContainer/HBoxContainerCharacterSelect/VBoxContainer2/HBoxContainer/JapaneseButton2
@onready var samoanButton2 = $MarginContainer/VBoxContainer/HBoxContainerCharacterSelect/VBoxContainer2/HBoxContainer2/SamoanButton2
@onready var vikingButton2 = $MarginContainer/VBoxContainer/HBoxContainerCharacterSelect/VBoxContainer2/HBoxContainer2/VikingButton2
@onready var mexicanButton2 = $MarginContainer/VBoxContainer/HBoxContainerCharacterSelect/VBoxContainer2/HBoxContainer2/MexicanButton2
var defaultColor = Color(1, 1, 1)
var selectedColor = Color(0.224, 1, 0.416)

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Loaded")

func _on_start_pressed():
	if !localPlayer1Controller && !localPlayer2Controller:
		print("Cannot Have 2 Keyboards!")
	else:
		global_script.globalPlayerCharacter1 = player1Character
		global_script.globalPlayerCharacter2 = player2Character
		global_script.player1Controller = localPlayer1Controller
		global_script.player2Controller = localPlayer2Controller
		get_tree().change_scene_to_file("res://scenes/Level.tscn")


func _on_african_button_1_pressed():
	player1Character = 1
	reset_selection_1()
	africanButton1.self_modulate = selectedColor


func _on_chinese_button_1_pressed():
	player1Character = 2
	reset_selection_1()
	chineseButton1.self_modulate = selectedColor

func _on_japanese_button_1_pressed():
	player1Character = 3
	reset_selection_1()
	japaneseButton1.self_modulate = selectedColor

func _on_samoan_button_1_pressed():
	player1Character = 4
	reset_selection_1()
	samoanButton1.self_modulate = selectedColor

func _on_viking_button_1_pressed():
	player1Character = 5
	reset_selection_1()
	vikingButton1.self_modulate = selectedColor

func _on_mexican_button_1_pressed():
	player1Character = 6
	reset_selection_1()
	mexicanButton1.self_modulate = selectedColor

func _on_african_button_2_pressed():
	player2Character = 1
	reset_selection_2()
	africanButton2.self_modulate = selectedColor

func _on_chinese_button_2_pressed():
	player2Character = 2
	reset_selection_2()
	chineseButton2.self_modulate = selectedColor

func _on_japanese_button_2_pressed():
	player2Character = 3
	reset_selection_2()
	japaneseButton2.self_modulate = selectedColor

func _on_samoan_button_2_pressed():
	player2Character = 4
	reset_selection_2()
	samoanButton2.self_modulate = selectedColor

func _on_viking_button_2_pressed():
	player2Character = 5
	reset_selection_2()
	vikingButton2.self_modulate = selectedColor

func _on_mexican_button_2_pressed():
	player2Character = 6
	reset_selection_2()
	mexicanButton2.self_modulate = selectedColor


func _on_controller_player_1_pressed():
	localPlayer1Controller = true
	controllerPlayer1Button.texture_normal = controllerIconOn
	keyboardPlayer1Button.texture_normal = keyboardIconOff


func _on_keyboard_player_1_pressed():
	localPlayer1Controller = false
	controllerPlayer1Button.texture_normal = controllerIconOff
	keyboardPlayer1Button.texture_normal = keyboardIconOn


func _on_controller_player_2_pressed():
	localPlayer2Controller = true
	controllerPlayer2Button.texture_normal = controllerIconOn
	keyboardPlayer2Button.texture_normal = keyboardIconOff


func _on_keyboard_player_2_pressed():
	localPlayer2Controller = false
	controllerPlayer2Button.texture_normal = controllerIconOff
	keyboardPlayer2Button.texture_normal = keyboardIconOn


func _on_exit_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
	
func reset_selection_1():
	africanButton1.self_modulate = defaultColor
	chineseButton1.self_modulate = defaultColor
	japaneseButton1.self_modulate = defaultColor
	samoanButton1.self_modulate = defaultColor
	vikingButton1.self_modulate = defaultColor
	mexicanButton1.self_modulate = defaultColor
func reset_selection_2():
	africanButton2.self_modulate = defaultColor
	chineseButton2.self_modulate = defaultColor
	japaneseButton2.self_modulate = defaultColor
	samoanButton2.self_modulate = defaultColor
	vikingButton2.self_modulate = defaultColor
	mexicanButton2.self_modulate = defaultColor
