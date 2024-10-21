extends Node2D
# Assets
const africanMap = preload("res://assets/backgrounds/africa.png")
const chinaMap = preload("res://assets/backgrounds/china map pixel.png")
const japanMap = preload("res://assets/backgrounds/japan mapp.png")
const samoanMap = preload("res://assets/backgrounds/samoa.png")
const vikingMap = preload("res://assets/backgrounds/viking.png")
const mexicoMap = preload("res://assets/backgrounds/mexico final map.png")
const cratePath = preload("res://scenes/crate.tscn")
const africaMusic = preload("res://assets/audio/music/africa.mp3")
# Nodes
@onready var global_script = $"/root/Global"
@onready var africanTileMap = $Africa
@onready var chineseTileMap = $China
@onready var japaneseTileMap = $Japan
@onready var samoanTileMap = $Samoa
@onready var vikingTileMap = $Viking
@onready var mexicoTileMap = $Mexico
@onready var background = $TextureRect
@onready var mapAudioPlayer = $MusicAudioPlayer
# Variables
var randomTime : int
var timeLeft : int
var paused : bool
# Called when the node enters the scene tree for the first time.
func _ready():
	global_script.crateNumber = 0
	if global_script.mapType == 1:
		mapAudioPlayer.stream = africaMusic
		mapAudioPlayer.play()
		background.texture = africanMap
		africanTileMap.global_position.y = 0
		africanTileMap.visible = true
	elif global_script.mapType == 2:
		background.texture = chinaMap
		chineseTileMap.global_position.y = 0
		chineseTileMap.visible = true
	elif global_script.mapType == 3:
		background.texture = japanMap
		japaneseTileMap.global_position.y = 0
		japaneseTileMap.visible = true
	elif global_script.mapType == 4:
		background.texture = samoanMap
		samoanTileMap.global_position.y = 0
		samoanTileMap.visible = true
	elif global_script.mapType == 5:
		background.texture = vikingMap
		vikingTileMap.global_position.y = 0
		vikingTileMap.visible = true
	elif global_script.mapType == 6:
		background.texture = mexicoMap
		mexicoTileMap.global_position.y = 0
		mexicoTileMap.visible = true
	await get_tree().create_timer(randi_range(1, 2)).timeout
	create_box()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if paused:
		if !global_script.isPaused:
			decrease_timer()
			paused = false

func start_timer():
	randomTime = randi_range(6, 13)
	timeLeft = randomTime
	decrease_timer()

func decrease_timer():
	if timeLeft > 0:
		if !global_script.isPaused:
			await get_tree().create_timer(1).timeout
			timeLeft -= 1
			decrease_timer()
		else:
			paused = true
	else:
		create_box()
	

func create_box():
	if global_script.crateNumber < 2:
		var crate = cratePath.instantiate()
		crate.global_position = Vector2(randi_range(-350, 350), -360)
		global_script.crateNumber += 1
		add_child(crate)
	start_timer()
