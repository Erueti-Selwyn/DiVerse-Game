extends Node
# Assets
const africanBackground = preload("res://assets/backgrounds/africa.png")
const chineseBackground = preload("res://assets/backgrounds/china map pixel.png")
const japaneseBackground = preload("res://assets/backgrounds/japan mapp.png")
const samoanBackground = preload("res://assets/backgrounds/samoa.png")
const vikingBackground = preload("res://assets/backgrounds/viking.png")
const mexicanBackground = preload("res://assets/backgrounds/mexico final map.png")
# Nodes
@onready var global_script = $"/root/Global"
@onready var background = $background
@onready var winnerTitle = $HBoxContainer/VBoxContainer/Label
# Called when the node enters the scene tree for the first time.
func _ready():
	winnerTitle.text = "Player "  + str(global_script.winningPlayer) + " Wins!"
	if global_script.mapType == 1:
		background.texture = africanBackground
	elif global_script.mapType == 2:
		background.texture = chineseBackground
	elif global_script.mapType == 3:
		background.texture = japaneseBackground
	elif global_script.mapType == 4:
		background.texture = samoanBackground
	elif global_script.mapType == 5:
		background.texture = vikingBackground
	elif global_script.mapType == 6:
		background.texture = mexicanBackground


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_menu_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
