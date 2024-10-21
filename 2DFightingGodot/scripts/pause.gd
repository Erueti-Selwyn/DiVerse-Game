extends Control
# Nodes
@onready var global_script = $"/root/Global"
@onready var settingsMenu = $"../settings_menu"
@onready var resumeButton = $MarginContainer/VBoxContainer/ResumeButton
@onready var optionsButton = $MarginContainer/VBoxContainer/OptionsButton
@onready var exitButton = $MarginContainer/VBoxContainer/ExitButton
@onready var pauseHighlight = $"../PauseHighlight"
@onready var level = $".."
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
		pauseHighlight.visible = false
		global_script.isPaused = false
	else:
		self.show()
		pauseHighlight.visible = true
		global_script.isPaused = true
	paused = !paused

func _on_resume_button_pressed():
	global_script.button_jump(resumeButton)
	await get_tree().create_timer(0.05).timeout
	pauseMenu()


func _on_options_button_pressed():
	global_script.button_jump(optionsButton)
	settingsMenu.from_pause_menu()
	settingsMenu.open_settings_menu()


func _on_exit_button_pressed():
	global_script.button_jump(exitButton)
	await get_tree().create_timer(0.05).timeout
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
	pauseMenu()
