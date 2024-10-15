extends Node2D
const africanMap = preload("res://assets/backgrounds/africa.png")
const chinaMap = preload("res://assets/backgrounds/china map pixel.png")
const japanMap = preload("res://assets/backgrounds/japan mapp.png")
const samoanMap = preload("res://assets/backgrounds/samoa.png")
const vikingMap = preload("res://assets/backgrounds/viking.png")
const mexicoMap = preload("res://assets/backgrounds/mexico final map.png")
const cratePath = preload("res://scenes/crate.tscn")
@onready var africanTileMap = $Africa
@onready var chineseTileMap = $China
@onready var japaneseTileMap = $Japan
@onready var samoanTileMap = $Samoa
@onready var vikingTileMap = $Viking
@onready var mexicoTileMap = $Mexico
@onready var global_script = $"/root/Global"
@onready var background = $TextureRect
var randomTime
# Called when the node enters the scene tree for the first time.
func _ready():
	if global_script.mapType == 1:
		background.texture = africanMap
	elif global_script.mapType == 2:
		background.texture = chinaMap
	elif global_script.mapType == 3:
		background.texture = japanMap
	elif global_script.mapType == 4:
		background.texture = samoanMap
	elif global_script.mapType == 5:
		background.texture = vikingMap
	elif global_script.mapType == 6:
		background.texture = mexicoMap
	await get_tree().create_timer(randi_range(1, 2)).timeout
	create_box()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pass

func start_timer():
	randomTime = randi_range(20, 40)
	await get_tree().create_timer(randomTime).timeout
	create_box()

func create_box():
	if global_script.crateNumber < 2:
		var crate = cratePath.instantiate()
		crate.global_position = Vector2(randi_range(-350, 350), -360)
		global_script.crateNumber += 1
		add_child(crate)
	start_timer()
