extends Control
# Nodes
@onready var global_script = $"/root/Global"
@onready var settingsMenu = $"../settings_menu"
# Variables
var paused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		pauseMenu()

func pauseMenu():
	if paused:
		self.hide()
		Engine.time_scale = 1
		global_script.isPaused = false
	else:
		self.show()
		Engine.time_scale = 0
		global_script.isPaused = true
	paused = !paused

func _on_resume_button_pressed():
	pauseMenu()


func _on_options_button_pressed():
	settingsMenu.from_pause_menu()
	settingsMenu.visible = true
	self.hide()


func _on_exit_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
	pauseMenu()
