extends Node2D
# Assets
const AFRICA_MAP = preload("res://assets/backgrounds/africa.png")
const CHINA_MAP = preload("res://assets/backgrounds/china map pixel.png")
const JAPAN_MAP = preload("res://assets/backgrounds/japan mapp.png")
const SAMOAN_MAP = preload("res://assets/backgrounds/samoa.png")
const VIKING_MAP = preload("res://assets/backgrounds/viking.png")
const MEXICO_MAP = preload("res://assets/backgrounds/mexico final map.png")
const CRATE_PATH = preload("res://scenes/crate.tscn")
# Nodes
@onready var global_script = $"/root/Global"
@onready var global_map_audio_player = $"/root/MapMusicAudioPlayer"
@onready var african_tile_map = $Africa
@onready var chinese_tile_map = $China
@onready var japanese_tile_map = $Japan
@onready var samoan_tile_map = $Samoa
@onready var viking_tile_map = $Viking
@onready var mexico_tile_map = $Mexico
@onready var background = $TextureRect
# Variables
var random_time : int
var time_left : int
var paused : bool


func _ready():
	# Sets variables.
	global_script.is_on_level = true
	global_script.is_on_menu = false
	global_map_audio_player.play_map_music()
	global_script.crate_number = 0
	# Sets background image.
	if global_script.map_type == 1:
		background.texture = AFRICA_MAP
		african_tile_map.global_position.y = 0
		african_tile_map.visible = true
	elif global_script.map_type == 2:
		background.texture = CHINA_MAP
		chinese_tile_map.global_position.y = 0
		chinese_tile_map.visible = true
	elif global_script.map_type == 3:
		background.texture = JAPAN_MAP
		japanese_tile_map.global_position.y = 0
		japanese_tile_map.visible = true
	elif global_script.map_type == 4:
		background.texture = SAMOAN_MAP
		samoan_tile_map.global_position.y = 0
		samoan_tile_map.visible = true
	elif global_script.map_type == 5:
		background.texture = VIKING_MAP
		viking_tile_map.global_position.y = 0
		viking_tile_map.visible = true
	elif global_script.map_type == 6:
		background.texture = MEXICO_MAP
		mexico_tile_map.global_position.y = 0
		mexico_tile_map.visible = true
	# Creates first box.
	await get_tree().create_timer(randi_range(1, 2)).timeout
	create_box()


func create_box():
	# Checks if can create box.
	if global_script.crate_number < 2:
		var crate = CRATE_PATH.instantiate()
		# Moves box to random x position on map
		crate.global_position = Vector2(randi_range(-350, 350), -360)
		global_script.crate_number += 1
		add_child(crate)
	start_timer()


func _physics_process(_delta):
	if paused:
		if !global_script.is_paused:
			decrease_timer()
			paused = false


func start_timer():
	# Generates random timer
	random_time = randi_range(6, 13)
	time_left = random_time
	decrease_timer()


func decrease_timer():
	# Decreases timer 1 per second.
	if time_left > 0:
		if !global_script.is_paused:
			await get_tree().create_timer(1).timeout
			time_left -= 1
			decrease_timer()
		else:
			paused = true
	else:
		create_box()
