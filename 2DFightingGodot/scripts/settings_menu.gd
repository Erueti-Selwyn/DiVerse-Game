extends Control

@onready var global_script = $"/root/Global"
@onready var soundSwitch = $MarginContainer/VBoxContainer/HBoxContainer/SoundButton
@onready var musicSwitch = $MarginContainer/VBoxContainer/HBoxContainer2/MusicButton
@onready var pauseMenu = $"../pause"
@onready var controlsMenu = $"../controls"
var localSoundOn = true
var localMusicOn = true
var fromPauseMenu = false

func _ready():
	print("Loaded")
	if global_script.player1Controller == true:
		optionPlayerButton1.select(0)
	else:
		optionPlayerButton1.select(1)
	if global_script.player2Controller == true:
		optionPlayerButton2.select(0)
	else:
		optionPlayerButton2.select(1)

func _on_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func _on_sound_button_pressed():
	if localSoundOn:
		soundSwitch.texture_normal = switchOff
		soundSwitch.texture_click_mask = swtichOffMask
		localSoundOn = false
	elif !localSoundOn:
		soundSwitch.texture_normal = switchOn
		soundSwitch.texture_click_mask = swtichOnMask
		localSoundOn = true

func _on_music_button_pressed():
	if localMusicOn:
		musicSwitch.texture_normal = switchOff
		musicSwitch.texture_click_mask = swtichOffMask
		localMusicOn = false
	elif !localMusicOn:
		musicSwitch.texture_normal = switchOn
		musicSwitch.texture_click_mask = swtichOnMask
		localMusicOn = true


func _on_exit_button_pressed():
	self.visible = false
	if fromPauseMenu:
		fromPauseMenu = false
		pauseMenu.show()
	
func from_pause_menu():
	fromPauseMenu = true


func _on_controls_pressed():
	controlsMenu.visible = true
