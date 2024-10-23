extends Control
# Assets
const SWITCH_ON = preload("res://assets/Ui Assets/optionButtonOn.png")
const SWITCH_OFF = preload("res://assets/Ui Assets/optionButtonOff.png")
const SWITCH_ON_MASK = preload("res://assets/Ui Assets/optionButtonOnMask.png")
const SWITCH_OFF_MASK = preload("res://assets/Ui Assets/optionButtonOffMask.png")
# Nodes
@onready var global_script = $"/root/Global"
@onready var global_click_audio_player = $"/root/ClickAudioPlayer"
@onready var global_menu_audio_player = $"/root/MenuAudioPlayer"
@onready var global_map_audio_player = $"/root/MapMusicAudioPlayer"
@onready var sound_switch = $MarginContainer/VBoxContainer/HBoxContainer/SoundButton
@onready var music_switch = $MarginContainer/VBoxContainer/HBoxContainer2/MusicButton
@onready var pause_menu = $"../pause"
@onready var controls_menu = $"../controls"
@onready var exit_button = $MarginContainer/VBoxContainer/HBoxContainer3/ExitButton
@onready var controls_button = $MarginContainer/VBoxContainer/Controls
@onready var click_audio_player = $"../ClickAudioPlayer"
# Variables
var from_pause_menu : bool = false

func _ready():
	self.pivot_offset = Vector2(self.size / 2)
	if global_script.music_on:
		music_switch.texture_normal = SWITCH_ON
	elif !global_script.music_on:
		music_switch.texture_normal = SWITCH_OFF
	if global_script.sound_on:
		sound_switch.texture_normal = SWITCH_ON
	elif !global_script.sound_on:
		sound_switch.texture_normal = SWITCH_OFF
	
func _process(_delta):
	pass
func _on_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func _on_sound_button_pressed():
	global_click_audio_player.click_button_effect()
	global_script.button_jump(sound_switch)
	if global_script.sound_on:
		sound_switch.texture_normal = SWITCH_OFF
		sound_switch.texture_click_mask = SWITCH_OFF_MASK
		global_script.sound_on = false
	elif !global_script.sound_on:
		sound_switch.texture_normal = SWITCH_ON
		sound_switch.texture_click_mask = SWITCH_ON_MASK
		global_script.sound_on = true

func _on_music_button_pressed():
	global_click_audio_player.click_button_effect()
	global_script.button_jump(music_switch)
	if global_script.music_on:
		music_switch.texture_normal = SWITCH_OFF
		music_switch.texture_click_mask = SWITCH_OFF_MASK
		global_script.music_on = false
		global_menu_audio_player.stop_menu_music()
		global_map_audio_player.stop_map_music()
	elif !global_script.music_on:
		music_switch.texture_normal = SWITCH_ON
		music_switch.texture_click_mask = SWITCH_ON_MASK
		global_script.music_on = true
		global_menu_audio_player.play_menu_music()
		global_map_audio_player.play_map_music()

func _on_exit_button_pressed():
	global_script.button_jump(exit_button)
	global_click_audio_player.click_button_effect()
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(0.1, 0.1), 0.1).set_ease(Tween.EASE_IN)
	await tween.finished
	self.visible = false
	
func open_settings_menu():
	scale = Vector2(0.1, 0.1)
	self.visible = true
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1), 0.1).set_ease(Tween.EASE_OUT)
	
func is_from_pause_menu():
	from_pause_menu = true


func _on_controls_pressed():
	global_click_audio_player.click_button_effect()
	global_script.button_jump(controls_button)
	controls_menu.open_menu()
