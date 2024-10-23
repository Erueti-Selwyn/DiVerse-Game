extends Node2D
# Assets
const AFRICA_MAP = preload("res://assets/backgrounds/africa.png")
const CHINA_MAP = preload("res://assets/backgrounds/china map pixel.png")
const JAPAN_MAP = preload("res://assets/backgrounds/japan mapp.png")
const SAMOAN_MAP = preload("res://assets/backgrounds/samoa.png")
const VIKING_MAP = preload("res://assets/backgrounds/viking.png")
const MEXICO_MAP = preload("res://assets/backgrounds/mexico final map.png")
const CRATE_PATH = preload("res://scenes/crate.tscn")
const AFRICA_MUSIC = preload("res://assets/audio/music/africa.mp3")
const CHINA_MUSIC = preload("res://assets/audio/music/china map music.mp3")
const JAPAN_MUSIC = preload("res://assets/audio/music/japanese map music.mp3")
const MEXICO_MUSIC = preload("res://assets/audio/music/mexico map music.mp3")
const SAMOAN_MUSIC = preload("res://assets/audio/music/samoa map music.mp3")
const VIKING_MUSIC = preload("res://assets/audio/music/viking map music.mp3")
# Nodes
@onready var global_script = $"/root/Global"
@onready var african_tile_map = $Africa
@onready var chinese_tile_map = $China
@onready var japanese_tile_map = $Japan
@onready var samoan_tile_map = $Samoa
@onready var viking_tile_map = $Viking
@onready var mexico_tile_map = $Mexico
@onready var background = $TextureRect
@onready var map_audio_player = $MusicAudioPlayer
# Variables
var random_time : int
var time_left : int
var paused : bool


# Called when the node enters the scene tree for the first time.
func _ready():
	global_script.crate_number = 0
	if global_script.map_type == 1:
		map_audio_player.stream = AFRICA_MUSIC
		background.texture = AFRICA_MAP
		african_tile_map.global_position.y = 0
		african_tile_map.visible = true
	elif global_script.map_type == 2:
		map_audio_player.stream = CHINA_MUSIC
		background.texture = CHINA_MAP
		chinese_tile_map.global_position.y = 0
		chinese_tile_map.visible = true
	elif global_script.map_type == 3:
		map_audio_player.stream = JAPAN_MUSIC
		background.texture = JAPAN_MAP
		japanese_tile_map.global_position.y = 0
		japanese_tile_map.visible = true
	elif global_script.map_type == 4:
		map_audio_player.stream = SAMOAN_MUSIC
		background.texture = SAMOAN_MAP
		samoan_tile_map.global_position.y = 0
		samoan_tile_map.visible = true
	elif global_script.map_type == 5:
		map_audio_player.stream = VIKING_MUSIC
		background.texture = VIKING_MAP
		viking_tile_map.global_position.y = 0
		viking_tile_map.visible = true
	elif global_script.map_type == 6:
		map_audio_player.stream = MEXICO_MUSIC
		background.texture = MEXICO_MAP
		mexico_tile_map.global_position.y = 0
		mexico_tile_map.visible = true
	if global_script.music_on:
			map_audio_player.stream.loop = true
			map_audio_player.play()
	await get_tree().create_timer(randi_range(1, 2)).timeout
	create_box()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if paused:
		if !global_script.is_paused:
			decrease_timer()
			paused = false


func start_timer():
	random_time = randi_range(6, 13)
	time_left = random_time
	decrease_timer()


func decrease_timer():
	if time_left > 0:
		if !global_script.is_paused:
			await get_tree().create_timer(1).timeout
			time_left -= 1
			decrease_timer()
		else:
			paused = true
	else:
		create_box()


func create_box():
	if global_script.crate_number < 2:
		var crate = CRATE_PATH.instantiate()
		crate.global_position = Vector2(randi_range(-350, 350), -360)
		global_script.crate_number += 1
		add_child(crate)
	start_timer()
