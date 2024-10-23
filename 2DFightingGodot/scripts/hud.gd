extends Control
# Assets
const AFRICAN_PROFILE = preload("res://assets/profiles/africa man profile.aesprite.png")
const CHINESE_PROFILE = preload("res://assets/profiles/china profile.aesprite.png")
const JAPANESE_PROFILE = preload("res://assets/profiles/japan man profile.aesprite.png")
const SAMOAN_PROFILE = preload("res://assets/profiles/samoan body profile.aesprite.png")
const VIKING_PROFILE = preload("res://assets/profiles/viking profile.aesprite.png")
const MEXICAN_PROFILE = preload("res://assets/profiles/Mexican-profile.png")
const HEART_ALIVE = preload("res://assets/Ui Assets/heart.png")
const HEART_DEAD = preload("res://assets/Ui Assets/heartdead.png")
# Nodes
@onready var global_script = $"/root/Global"
@onready var player_1_label = $VBoxContainer/HBoxContainer/Player1/HP1
@onready var player_2_label = $VBoxContainer/HBoxContainer/Player2/HP2
@onready var player_1_icon = $VBoxContainer/HBoxContainer/Player1/Background/Icon1
@onready var player_2_icon = $VBoxContainer/HBoxContainer/Player2/Background/Icon2
@onready var player_1_health_1 = $VBoxContainer/HBoxContainer/Player1/TopBorder/HBoxContainer/Heart1
@onready var player_1_health_2 = $VBoxContainer/HBoxContainer/Player1/TopBorder/HBoxContainer/Heart2
@onready var player_1_health_3 = $VBoxContainer/HBoxContainer/Player1/TopBorder/HBoxContainer/Heart3
@onready var player_2_health_1 = $VBoxContainer/HBoxContainer/Player2/TopBorder/HBoxContainer/Heart1
@onready var player_2_health_2 = $VBoxContainer/HBoxContainer/Player2/TopBorder/HBoxContainer/Heart2
@onready var player_2_health_3 = $VBoxContainer/HBoxContainer/Player2/TopBorder/HBoxContainer/Heart3
# Variables
var local_player_1_health : int
var local_player_2_health : int
var local_player_1_lives : int
var local_player_2_lives : int


func _process(_delta):
	local_player_1_health = global_script.player_1_health
	local_player_2_health = global_script.player_2_health
	local_player_1_lives = global_script.global_player_1_lives
	local_player_2_lives = global_script.global_player_2_lives
	player_1_label.text = str(local_player_1_health)
	player_2_label.text = str(local_player_2_health)
	if global_script.global_player_1_lives == 3:
		player_1_health_1.texture = HEART_ALIVE
		player_1_health_2.texture = HEART_ALIVE
		player_1_health_3.texture = HEART_ALIVE
	elif global_script.global_player_1_lives == 2:
		player_1_health_1.texture = HEART_ALIVE
		player_1_health_2.texture = HEART_ALIVE
		player_1_health_3.texture = HEART_DEAD
	elif global_script.global_player_1_lives == 1:
		player_1_health_1.texture = HEART_ALIVE
		player_1_health_2.texture = HEART_DEAD
		player_1_health_3.texture = HEART_DEAD
	elif global_script.global_player_1_lives == 0:
		player_1_health_1.texture = HEART_DEAD
		player_1_health_2.texture = HEART_DEAD
		player_1_health_3.texture = HEART_DEAD
		
	if global_script.global_player_2_lives == 3:
		player_2_health_1.texture = HEART_ALIVE
		player_2_health_2.texture = HEART_ALIVE
		player_2_health_3.texture = HEART_ALIVE
	elif global_script.global_player_2_lives == 2:
		player_2_health_1.texture = HEART_ALIVE
		player_2_health_2.texture = HEART_ALIVE
		player_2_health_3.texture = HEART_DEAD
	elif global_script.global_player_2_lives == 1:
		player_2_health_1.texture = HEART_ALIVE
		player_2_health_2.texture = HEART_DEAD
		player_2_health_3.texture = HEART_DEAD
	elif global_script.global_player_2_lives <= 0:
		player_2_health_1.texture = HEART_DEAD
		player_2_health_2.texture = HEART_DEAD
		player_2_health_3.texture = HEART_DEAD
	
	if global_script.global_player_character_1 == 1:
		player_1_icon.texture = AFRICAN_PROFILE
	elif global_script.global_player_character_1 == 2:
		player_1_icon.texture = CHINESE_PROFILE
	elif global_script.global_player_character_1 == 3:
		player_1_icon.texture = JAPANESE_PROFILE
	elif global_script.global_player_character_1 == 4: 
		player_1_icon.texture = SAMOAN_PROFILE
	elif global_script.global_player_character_1 == 5:
		player_1_icon.texture = VIKING_PROFILE
	elif global_script.global_player_character_1 == 6:
		player_1_icon.texture = MEXICAN_PROFILE

	if global_script.global_player_character_2 == 1:
		player_2_icon.texture = AFRICAN_PROFILE
	elif global_script.global_player_character_2 == 2:
		player_2_icon.texture = CHINESE_PROFILE
	elif global_script.global_player_character_2 == 3:
		player_2_icon.texture = JAPANESE_PROFILE
	elif global_script.global_player_character_2 == 4: 
		player_2_icon.texture = SAMOAN_PROFILE
	elif global_script.global_player_character_2 == 5:
		player_2_icon.texture = VIKING_PROFILE
	elif global_script.global_player_character_2 == 6:
		player_2_icon.texture = MEXICAN_PROFILE
