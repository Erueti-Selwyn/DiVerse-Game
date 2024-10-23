extends Control
# Assets
const CONTROLLER_ICON_OFF = preload("res://assets/Ui Assets/ControllerButtonOffFinal.png")
const CONTROLLER_ICON_ON = preload("res://assets/Ui Assets/ControllerButtonOnFinal.png")
const KEYBOARD_ICON_OFF = preload("res://assets/Ui Assets/MouseButtonOffFinal.png")
const KEYBOARD_ICON_ON = preload("res://assets/Ui Assets/MouseButtonOnFinal.png")
const AFRICA_MAP = preload("res://assets/backgrounds/africa.png")
const CHINA_MAP = preload("res://assets/backgrounds/china map pixel.png")
const JAPAN_MAP = preload("res://assets/backgrounds/japan mapp.png")
const SAMOA_MAP = preload("res://assets/backgrounds/samoa.png")
const VIKING_MAP = preload("res://assets/backgrounds/viking.png")
const MEXICO_MAP = preload("res://assets/backgrounds/mexico final map.png")
# Nodes
@onready var global_script = $"/root/Global"
@onready var global_click_audio_player = $"/root/ClickAudioPlayer"
@onready var global_menu_audio_player = $"/root/MenuAudioPlayer"
@onready var global_play_audio_player = $"/root/PlayButtonAudioPlayer"
@onready var click_audio_player = $ClickAudioPlayer
@onready var play_audio_player = $PlayAudioPlayer
@onready var start_button = $MarginContainer/VBoxContainer/Start
@onready var exit_button = $MarginContainer/VBoxContainer/Exit
@onready var keyboard_player_1_button = $MarginContainer/VBoxContainer/HBoxContainer3/HBoxContainer/KeyboardPlayer1
@onready var controller_player_1_button = $MarginContainer/VBoxContainer/HBoxContainer3/HBoxContainer/ControllerPlayer1
@onready var keyboard_player_2_button = $MarginContainer/VBoxContainer/HBoxContainer3/HBoxContainer2/KeyboardPlayer2
@onready var controller_player_2_button = $MarginContainer/VBoxContainer/HBoxContainer3/HBoxContainer2/ControllerPlayer2
@onready var african_button_1 = $MarginContainer/VBoxContainer/HBoxContainerCharacterSelect/VBoxContainer/HBoxContainer/AfricanButton1
@onready var chinese_button_1 = $MarginContainer/VBoxContainer/HBoxContainerCharacterSelect/VBoxContainer/HBoxContainer/ChineseButton1
@onready var japanese_button_1 = $MarginContainer/VBoxContainer/HBoxContainerCharacterSelect/VBoxContainer/HBoxContainer/JapaneseButton1
@onready var samoan_button_1 = $MarginContainer/VBoxContainer/HBoxContainerCharacterSelect/VBoxContainer/HBoxContainer2/SamoanButton1
@onready var viking_button_1 = $MarginContainer/VBoxContainer/HBoxContainerCharacterSelect/VBoxContainer/HBoxContainer2/VikingButton1
@onready var mexican_button_1 = $MarginContainer/VBoxContainer/HBoxContainerCharacterSelect/VBoxContainer/HBoxContainer2/MexicanButton1
@onready var african_button_2 = $MarginContainer/VBoxContainer/HBoxContainerCharacterSelect/VBoxContainer2/HBoxContainer/AfricanButton2
@onready var chinese_button_2 = $MarginContainer/VBoxContainer/HBoxContainerCharacterSelect/VBoxContainer2/HBoxContainer/ChineseButton2
@onready var japanese_button_2 = $MarginContainer/VBoxContainer/HBoxContainerCharacterSelect/VBoxContainer2/HBoxContainer/JapaneseButton2
@onready var samoan_button_2 = $MarginContainer/VBoxContainer/HBoxContainerCharacterSelect/VBoxContainer2/HBoxContainer2/SamoanButton2
@onready var viking_button_2 = $MarginContainer/VBoxContainer/HBoxContainerCharacterSelect/VBoxContainer2/HBoxContainer2/VikingButton2
@onready var mexican_button_2 = $MarginContainer/VBoxContainer/HBoxContainerCharacterSelect/VBoxContainer2/HBoxContainer2/MexicanButton2
@onready var african_map_button = $MarginContainer/VBoxContainer/HBoxContainerCharacterSelect/VBoxMaps/HBoxContainer/AfricaMap
@onready var chinese_map_button = $MarginContainer/VBoxContainer/HBoxContainerCharacterSelect/VBoxMaps/HBoxContainer/ChinaMap
@onready var japanese_map_button = $MarginContainer/VBoxContainer/HBoxContainerCharacterSelect/VBoxMaps/HBoxContainer/JapanMap
@onready var samoan_map_button = $MarginContainer/VBoxContainer/HBoxContainerCharacterSelect/VBoxMaps/HBoxContainer2/SamoaMap
@onready var viking_map_button = $MarginContainer/VBoxContainer/HBoxContainerCharacterSelect/VBoxMaps/HBoxContainer2/VikingMap
@onready var mexican_map_button = $MarginContainer/VBoxContainer/HBoxContainerCharacterSelect/VBoxMaps/HBoxContainer2/MexicoMap
@onready var background = $TextureRect
# Variables
var player_1_character : int = 1
var player_2_character : int = 1
var local_player_1_controller : bool = true
var local_player_2_controller : bool = true
var default_color = Color(1, 1, 1)
var selected_color = Color(0.224, 1, 0.416)


func _process(_delta):
	global_script.global_player_character_1 = player_1_character
	global_script.global_player_character_2 = player_2_character


func _on_start_pressed():
	global_script.button_jump(start_button)
	global_play_audio_player.play_button_effect()
	await get_tree().create_timer(0.05).timeout
	global_script.global_player_character_1 = player_1_character
	global_script.global_player_character_2 = player_2_character
	global_script.player_1_controller = local_player_1_controller
	global_script.player_2_controller = local_player_2_controller
	global_menu_audio_player.stop_menu_music()
	global_script.load_level_scene()


func _on_african_button_1_pressed():
	global_click_audio_player.click_button_effect()
	player_1_character = 1
	reset_selection_1()
	african_button_1.self_modulate = selected_color
	global_script.button_jump(african_button_1)


func _on_chinese_button_1_pressed():
	global_click_audio_player.click_button_effect()
	player_1_character = 2
	reset_selection_1()
	chinese_button_1.self_modulate = selected_color
	global_script.button_jump(chinese_button_1)


func _on_japanese_button_1_pressed():
	global_click_audio_player.click_button_effect()
	player_1_character = 3
	reset_selection_1()
	japanese_button_1.self_modulate = selected_color
	global_script.button_jump(japanese_button_1)


func _on_samoan_button_1_pressed():
	global_click_audio_player.click_button_effect()
	player_1_character = 4
	reset_selection_1()
	samoan_button_1.self_modulate = selected_color
	global_script.button_jump(samoan_button_1)


func _on_viking_button_1_pressed():
	global_click_audio_player.click_button_effect()
	player_1_character = 5
	reset_selection_1()
	viking_button_1.self_modulate = selected_color
	global_script.button_jump(viking_button_1)


func _on_mexican_button_1_pressed():
	global_click_audio_player.click_button_effect()
	player_1_character = 6
	reset_selection_1()
	mexican_button_1.self_modulate = selected_color
	global_script.button_jump(mexican_button_1)


func _on_african_button_2_pressed():
	global_click_audio_player.click_button_effect()
	player_2_character = 1
	reset_selection_2()
	african_button_2.self_modulate = selected_color
	global_script.button_jump(african_button_2)


func _on_chinese_button_2_pressed():
	global_click_audio_player.click_button_effect()
	player_2_character = 2
	reset_selection_2()
	chinese_button_2.self_modulate = selected_color
	global_script.button_jump(chinese_button_2)


func _on_japanese_button_2_pressed():
	global_click_audio_player.click_button_effect()
	player_2_character = 3
	reset_selection_2()
	japanese_button_2.self_modulate = selected_color
	global_script.button_jump(japanese_button_2)


func _on_samoan_button_2_pressed():
	global_click_audio_player.click_button_effect()
	player_2_character = 4
	reset_selection_2()
	samoan_button_2.self_modulate = selected_color
	global_script.button_jump(samoan_button_2)


func _on_viking_button_2_pressed():
	global_click_audio_player.click_button_effect()
	player_2_character = 5
	reset_selection_2()
	viking_button_2.self_modulate = selected_color
	global_script.button_jump(viking_button_2)


func _on_mexican_button_2_pressed():
	global_click_audio_player.click_button_effect()
	player_2_character = 6
	reset_selection_2()
	mexican_button_2.self_modulate = selected_color
	global_script.button_jump(mexican_button_2)


func _on_controller_player_1_pressed():
	global_click_audio_player.click_button_effect()
	local_player_1_controller = true
	controller_player_1_button.texture_normal = CONTROLLER_ICON_ON
	keyboard_player_1_button.texture_normal = KEYBOARD_ICON_OFF
	global_script.button_jump(controller_player_1_button)


func _on_keyboard_player_1_pressed():
	global_click_audio_player.click_button_effect()
	local_player_1_controller = false
	controller_player_1_button.texture_normal = CONTROLLER_ICON_OFF
	keyboard_player_1_button.texture_normal = KEYBOARD_ICON_ON
	global_script.button_jump(keyboard_player_1_button)


func _on_controller_player_2_pressed():
	global_click_audio_player.click_button_effect()
	local_player_2_controller = true
	controller_player_2_button.texture_normal = CONTROLLER_ICON_ON
	keyboard_player_2_button.texture_normal = KEYBOARD_ICON_OFF
	global_script.button_jump(controller_player_2_button)


func _on_keyboard_player_2_pressed():
	global_click_audio_player.click_button_effect()
	local_player_2_controller = false
	controller_player_2_button.texture_normal = CONTROLLER_ICON_OFF
	keyboard_player_2_button.texture_normal = KEYBOARD_ICON_ON
	global_script.button_jump(keyboard_player_2_button)


func _on_exit_pressed():
	global_click_audio_player.click_button_effect()
	global_script.button_jump(exit_button)
	await get_tree().create_timer(0.05).timeout
	global_script.load_menu_scene()


func reset_selection_1():
	african_button_1.self_modulate = default_color
	chinese_button_1.self_modulate = default_color
	japanese_button_1.self_modulate = default_color
	samoan_button_1.self_modulate = default_color
	viking_button_1.self_modulate = default_color
	mexican_button_1.self_modulate = default_color


func reset_selection_2():
	african_button_2.self_modulate = default_color
	chinese_button_2.self_modulate = default_color
	japanese_button_2.self_modulate = default_color
	samoan_button_2.self_modulate = default_color
	viking_button_2.self_modulate = default_color
	mexican_button_2.self_modulate = default_color


func _on_africa_map_pressed():
	global_click_audio_player.click_button_effect()
	global_script.map_type = 1
	background.texture = AFRICA_MAP
	global_script.button_jump(african_map_button)


func _on_china_map_pressed():
	global_click_audio_player.click_button_effect()
	global_script.map_type = 2
	background.texture = CHINA_MAP
	global_script.button_jump(chinese_map_button)


func _on_japan_map_pressed():
	global_click_audio_player.click_button_effect()
	global_script.map_type = 3
	background.texture = JAPAN_MAP
	global_script.button_jump(japanese_map_button)


func _on_samoa_map_pressed():
	global_click_audio_player.click_button_effect()
	global_script.map_type = 4
	background.texture = SAMOA_MAP
	global_script.button_jump(samoan_map_button)


func _on_viking_map_pressed():
	global_click_audio_player.click_button_effect()
	global_script.map_type = 5
	background.texture = VIKING_MAP
	global_script.button_jump(viking_map_button)


func _on_mexico_map_pressed():
	global_click_audio_player.click_button_effect()
	global_script.map_type = 6
	background.texture = MEXICO_MAP
	global_script.button_jump(mexican_map_button)
