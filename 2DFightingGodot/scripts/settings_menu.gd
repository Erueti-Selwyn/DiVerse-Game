extends Control
const switchOn = preload("res://assets/Ui Assets/optionButtonOn.png")
const switchOff = preload("res://assets/Ui Assets/optionButtonOff.png")
const swtichOnMask = preload("res://assets/Ui Assets/optionButtonOnMask.png")
const swtichOffMask = preload("res://assets/Ui Assets/optionButtonOffMask.png")
@onready var global_script = $"/root/Global"
@onready var soundSwitch = $MarginContainer/VBoxContainer/HBoxContainer/SoundButton
@onready var musicSwitch = $MarginContainer/VBoxContainer/HBoxContainer2/MusicButton
@onready var pauseMenu = $"../pause"
@onready var controlsMenu = $"../controls"
var localSoundOn = true
var localMusicOn = true
var fromPauseMenu = false

func _ready():
	localSoundOn = global_script.soundOn
	localMusicOn = global_script.musicOn
	
func _process(_delta):
	global_script.soundOn = localSoundOn
	global_script.musicOn = localMusicOn
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
