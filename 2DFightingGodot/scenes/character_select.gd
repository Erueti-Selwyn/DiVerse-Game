extends Control
# Assets
const controllerIconOff = preload("res://assets/Ui Assets/ControllerButtonOffFinal.png")
const controllerIconOn = preload("res://assets/Ui Assets/ControllerButtonOnFinal.png")
const keyboardIconOff = preload("res://assets/Ui Assets/MouseButtonOffFinal.png")
const keyboardIconOn = preload("res://assets/Ui Assets/MouseButtonOnFinal.png")
const africanMap = preload("res://assets/backgrounds/africa.png")
const chinaMap = preload("res://assets/backgrounds/china map pixel.png")
const japanMap = preload("res://assets/backgrounds/japan mapp.png")
const samoanMap = preload("res://assets/backgrounds/samoa.png")
const vikingMap = preload("res://assets/backgrounds/viking.png")
const mexicoMap = preload("res://assets/backgrounds/mexico final map.png")
# Nodes
@onready var global_script = $"/root/Global"
@onready var startButton = $MarginContainer/VBoxContainer/Start
@onready var exitButton = $MarginContainer/VBoxContainer/Exit
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
@onready var africanMapButton = $MarginContainer/VBoxContainer/HBoxContainerCharacterSelect/VBoxMaps/HBoxContainer/AfricaMap
@onready var chineseMapButton = $MarginContainer/VBoxContainer/HBoxContainerCharacterSelect/VBoxMaps/HBoxContainer/ChinaMap
@onready var japaneseMapButton = $MarginContainer/VBoxContainer/HBoxContainerCharacterSelect/VBoxMaps/HBoxContainer/JapanMap
@onready var samoanMapButton = $MarginContainer/VBoxContainer/HBoxContainerCharacterSelect/VBoxMaps/HBoxContainer2/SamoaMap
@onready var vikingMapButton = $MarginContainer/VBoxContainer/HBoxContainerCharacterSelect/VBoxMaps/HBoxContainer2/VikingMap
@onready var mexicanMapButton = $MarginContainer/VBoxContainer/HBoxContainerCharacterSelect/VBoxMaps/HBoxContainer2/MexicoMap
@onready var background = $TextureRect
# Variables
var player1Character : int = 1
var player2Character : int = 1
var localPlayer1Controller : bool = true
var localPlayer2Controller : bool = true
var defaultColor = Color(1, 1, 1)
var selectedColor = Color(0.224, 1, 0.416)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
func _process(_delta):
	global_script.globalPlayerCharacter1 = player1Character
	global_script.globalPlayerCharacter2 = player2Character
func _on_start_pressed():
	global_script.button_jump(startButton)
	await get_tree().create_timer(0.05).timeout
	global_script.globalPlayerCharacter1 = player1Character
	global_script.globalPlayerCharacter2 = player2Character
	global_script.player1Controller = localPlayer1Controller
	global_script.player2Controller = localPlayer2Controller
	get_tree().change_scene_to_file("res://scenes/Level.tscn")


func _on_african_button_1_pressed():
	player1Character = 1
	reset_selection_1()
	africanButton1.self_modulate = selectedColor
	global_script.button_jump(africanButton1)


func _on_chinese_button_1_pressed():
	player1Character = 2
	reset_selection_1()
	chineseButton1.self_modulate = selectedColor
	global_script.button_jump(chineseButton1)

func _on_japanese_button_1_pressed():
	player1Character = 3
	reset_selection_1()
	japaneseButton1.self_modulate = selectedColor
	global_script.button_jump(japaneseButton1)

func _on_samoan_button_1_pressed():
	player1Character = 4
	reset_selection_1()
	samoanButton1.self_modulate = selectedColor
	global_script.button_jump(samoanButton1)

func _on_viking_button_1_pressed():
	player1Character = 5
	reset_selection_1()
	vikingButton1.self_modulate = selectedColor
	global_script.button_jump(vikingButton1)

func _on_mexican_button_1_pressed():
	player1Character = 6
	reset_selection_1()
	mexicanButton1.self_modulate = selectedColor
	global_script.button_jump(mexicanButton1)

func _on_african_button_2_pressed():
	player2Character = 1
	reset_selection_2()
	africanButton2.self_modulate = selectedColor
	global_script.button_jump(africanButton2)

func _on_chinese_button_2_pressed():
	player2Character = 2
	reset_selection_2()
	chineseButton2.self_modulate = selectedColor
	global_script.button_jump(chineseButton2)

func _on_japanese_button_2_pressed():
	player2Character = 3
	reset_selection_2()
	japaneseButton2.self_modulate = selectedColor
	global_script.button_jump(japaneseButton2)

func _on_samoan_button_2_pressed():
	player2Character = 4
	reset_selection_2()
	samoanButton2.self_modulate = selectedColor
	global_script.button_jump(samoanButton2)

func _on_viking_button_2_pressed():
	player2Character = 5
	reset_selection_2()
	vikingButton2.self_modulate = selectedColor
	global_script.button_jump(vikingButton2)

func _on_mexican_button_2_pressed():
	player2Character = 6
	reset_selection_2()
	mexicanButton2.self_modulate = selectedColor
	global_script.button_jump(mexicanButton2)


func _on_controller_player_1_pressed():
	localPlayer1Controller = true
	controllerPlayer1Button.texture_normal = controllerIconOn
	keyboardPlayer1Button.texture_normal = keyboardIconOff
	global_script.button_jump(controllerPlayer1Button)


func _on_keyboard_player_1_pressed():
	localPlayer1Controller = false
	controllerPlayer1Button.texture_normal = controllerIconOff
	keyboardPlayer1Button.texture_normal = keyboardIconOn
	global_script.button_jump(keyboardPlayer1Button)


func _on_controller_player_2_pressed():
	localPlayer2Controller = true
	controllerPlayer2Button.texture_normal = controllerIconOn
	keyboardPlayer2Button.texture_normal = keyboardIconOff
	global_script.button_jump(controllerPlayer2Button)


func _on_keyboard_player_2_pressed():
	localPlayer2Controller = false
	controllerPlayer2Button.texture_normal = controllerIconOff
	keyboardPlayer2Button.texture_normal = keyboardIconOn
	global_script.button_jump(keyboardPlayer2Button)


func _on_exit_pressed():
	global_script.button_jump(exitButton)
	await get_tree().create_timer(0.05).timeout
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


func _on_africa_map_pressed():
	global_script.mapType = 1
	background.texture = africanMap
	global_script.button_jump(africanMapButton)

func _on_china_map_pressed():
	global_script.mapType = 2
	background.texture = chinaMap
	global_script.button_jump(chineseMapButton)

func _on_japan_map_pressed():
	global_script.mapType = 3
	background.texture = japanMap
	global_script.button_jump(japaneseMapButton)

func _on_samoa_map_pressed():
	global_script.mapType = 4
	background.texture = samoanMap
	global_script.button_jump(samoanMapButton)

func _on_viking_map_pressed():
	global_script.mapType = 5
	background.texture = vikingMap
	global_script.button_jump(vikingMapButton)

func _on_mexico_map_pressed():
	global_script.mapType = 6
	background.texture = mexicoMap
	global_script.button_jump(mexicanMapButton)
