extends Control
# Nodes
@onready var global_script = $"/root/Global"
@onready var globalMenuAudioPlayer = $"/root/MenuAudioPlayer"
@onready var globalClickAudioPlayer = $"/root/ClickAudioPlayer"
@onready var settingsMenu = $"settings_menu"
@onready var playButton = $MarginContainer/HBoxContainer/VBoxContainer/Play
@onready var settingsButton = $MarginContainer/HBoxContainer/VBoxContainer/Settings
@onready var quitButton = $MarginContainer/HBoxContainer/VBoxContainer/Quit
@onready var clickAudioPlayer = $ClickAudioPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	if global_script.musicOn:
		if !globalMenuAudioPlayer.is_menu_music_playing():
			globalMenuAudioPlayer.play_menu_music()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_play_pressed():
	globalClickAudioPlayer.click_button_effect()
	global_script.button_jump(playButton)
	globalClickAudioPlayer.click_button_effect()
	await get_tree().create_timer(0.05).timeout
	global_script.character_select_scene()


func _on_settings_pressed():
	globalClickAudioPlayer.click_button_effect()
	global_script.button_jump(settingsButton)
	settingsMenu.open_settings_menu()


func _on_quit_pressed():
	globalClickAudioPlayer.click_button_effect()
	global_script.button_jump(quitButton)
	await get_tree().create_timer(0.05).timeout
	get_tree().quit()
