extends Node
# Assets
const african_background = preload("res://assets/backgrounds/africa.png")
const chinese_background = preload("res://assets/backgrounds/china map pixel.png")
const japanese_background = preload("res://assets/backgrounds/japan mapp.png")
const samoan_background = preload("res://assets/backgrounds/samoa.png")
const viking_background = preload("res://assets/backgrounds/viking.png")
const mexican_background = preload("res://assets/backgrounds/mexico final map.png")
# Nodes
@onready var global_script = $"/root/Global"
@onready var global_click_audio_player = $"/root/ClickAudioPlayer"
@onready var background = $background
@onready var winner_title = $HBoxContainer/VBoxContainer/Label
@onready var menu_button = $MenuButton


func _ready():
	# Displays winner text.
	winner_title.text = "Player "  + str(global_script.winning_player) + " Wins!"
	# Changes background to map of game.
	if global_script.map_type == 1:
		background.texture = african_background
	elif global_script.map_type == 2:
		background.texture = chinese_background
	elif global_script.map_type == 3:
		background.texture = japanese_background
	elif global_script.map_type == 4:
		background.texture = samoan_background
	elif global_script.map_type == 5:
		background.texture = viking_background
	elif global_script.map_type == 6:
		background.texture = mexican_background


func _on_menu_button_pressed():
	global_script.button_jump(menu_button)
	await get_tree().create_timer(0.05).timeout
	global_script.load_menu_scene()
