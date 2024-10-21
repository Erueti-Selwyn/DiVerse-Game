extends Control
# Assets
const switchOn = preload("res://assets/Ui Assets/optionButtonOn.png")
const switchOff = preload("res://assets/Ui Assets/optionButtonOff.png")
const swtichOnMask = preload("res://assets/Ui Assets/optionButtonOnMask.png")
const swtichOffMask = preload("res://assets/Ui Assets/optionButtonOffMask.png")
# Nodes
@onready var global_script = $"/root/Global"
@onready var soundSwitch = $MarginContainer/VBoxContainer/HBoxContainer/SoundButton
@onready var musicSwitch = $MarginContainer/VBoxContainer/HBoxContainer2/MusicButton
@onready var pauseMenu = $"../pause"
@onready var controlsMenu = $"../controls"
@onready var exitButton = $MarginContainer/VBoxContainer/HBoxContainer3/ExitButton
@onready var controlsButton = $MarginContainer/VBoxContainer/Controls
@onready var clickAudioPlayer = $"../ClickAudioPlayer"
# Variables
var localSoundOn : bool = true
var localMusicOn : bool = true
var fromPauseMenu : bool = false

func _ready():
	self.pivot_offset = Vector2(self.size / 2)
	localSoundOn = global_script.soundOn
	localMusicOn = global_script.musicOn
	
func _process(_delta):
	global_script.soundOn = localSoundOn
	global_script.musicOn = localMusicOn
func _on_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func _on_sound_button_pressed():
	clickAudioPlayer.play()
	global_script.button_jump(soundSwitch)
	if localSoundOn:
		soundSwitch.texture_normal = switchOff
		soundSwitch.texture_click_mask = swtichOffMask
		localSoundOn = false
	elif !localSoundOn:
		soundSwitch.texture_normal = switchOn
		soundSwitch.texture_click_mask = swtichOnMask
		localSoundOn = true

func _on_music_button_pressed():
	clickAudioPlayer.play()
	global_script.button_jump(musicSwitch)
	if localMusicOn:
		musicSwitch.texture_normal = switchOff
		musicSwitch.texture_click_mask = swtichOffMask
		localMusicOn = false
	elif !localMusicOn:
		musicSwitch.texture_normal = switchOn
		musicSwitch.texture_click_mask = swtichOnMask
		localMusicOn = true


func _on_exit_button_pressed():
	global_script.button_jump(exitButton)
	clickAudioPlayer.play()
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(0.1, 0.1), 0.1).set_ease(Tween.EASE_IN)
	await tween.finished
	self.visible = false
	
func open_settings_menu():
	scale = Vector2(0.1, 0.1)
	self.visible = true
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1), 0.1).set_ease(Tween.EASE_OUT)
	
func from_pause_menu():
	fromPauseMenu = true


func _on_controls_pressed():
	clickAudioPlayer.play()
	global_script.button_jump(controlsButton)
	controlsMenu.open_menu()
