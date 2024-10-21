extends Control
# Nodes
@onready var global_script = $"/root/Global"
@onready var globalMenuAudioPlayer = $MenuAudioPlayer
@onready var settingsMenu = $"settings_menu"
@onready var playButton = $MarginContainer/HBoxContainer/VBoxContainer/Play
@onready var settingsButton = $MarginContainer/HBoxContainer/VBoxContainer/Settings
@onready var quitButton = $MarginContainer/HBoxContainer/VBoxContainer/Quit
# Called when the node enters the scene tree for the first time.
func _ready():
	globalMenuAudioPlayer.play_menu_music()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_play_pressed():
	global_script.button_jump(playButton)
	await get_tree().create_timer(0.05).timeout
	global_script.character_select_scene()


func _on_settings_pressed():
	global_script.button_jump(settingsButton)
	await get_tree().create_timer(0.05).timeout
	settingsMenu.visible = true


func _on_quit_pressed():
	global_script.button_jump(quitButton)
	await get_tree().create_timer(0.05).timeout
	get_tree().quit()
