extends Control
# Nodes
@onready var global_script = $"/root/Global"
@onready var global_menu_audio_player = $"/root/MenuAudioPlayer"
@onready var global_map_audio_player = $"/root/MapMusicAudioPlayer"
@onready var global_click_audio_player = $"/root/ClickAudioPlayer"
@onready var settings_menu = $"settings_menu"
@onready var play_button = $MarginContainer/HBoxContainer/VBoxContainer/Play
@onready var settings_button = $MarginContainer/HBoxContainer/VBoxContainer/Settings
@onready var quit_button = $MarginContainer/HBoxContainer/VBoxContainer/Quit


func _ready():
	global_script.is_on_level = false
	global_script.is_on_menu = true
	global_map_audio_player.stop_map_music()
	if global_script.music_on:
		global_menu_audio_player.play_menu_music()


func _on_play_pressed():
	global_click_audio_player.click_button_effect()
	global_script.button_jump(play_button)
	global_click_audio_player.click_button_effect()
	global_script.load_character_select_scene()


func _on_settings_pressed():
	global_click_audio_player.click_button_effect()
	global_script.button_jump(settings_button)
	settings_menu.open_settings_menu()


func _on_quit_pressed():
	global_click_audio_player.click_button_effect()
	global_script.button_jump(quit_button)
	await get_tree().create_timer(0.05).timeout
	get_tree().quit()
