extends Control
# Nodes
@onready var global_script = $"/root/Global"
@onready var global_click_audio_player = $"/root/ClickAudioPlayer"
@onready var settings_menu = $"../settings_menu"
@onready var resume_button = $MarginContainer/VBoxContainer/ResumeButton
@onready var options_button = $MarginContainer/VBoxContainer/OptionsButton
@onready var exit_button = $MarginContainer/VBoxContainer/ExitButton
@onready var pause_highlight = $"../PauseHighlight"
@onready var level = $".."
# Variables
var paused = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		toggle_pause_menu()


func toggle_pause_menu():
	if paused:
		self.hide()
		pause_highlight.visible = false
		global_script.is_paused = false
	else:
		self.show()
		pause_highlight.visible = true
		global_script.is_paused = true
	paused = !paused


func _on_resume_button_pressed():
	global_script.button_jump(resume_button)
	await get_tree().create_timer(0.05).timeout
	toggle_pause_menu()


func _on_options_button_pressed():
	global_script.button_jump(options_button)
	settings_menu.is_from_pause_menu()
	settings_menu.open_settings_menu()


func _on_exit_button_pressed():
	global_script.button_jump(exit_button)
	await get_tree().create_timer(0.05).timeout
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
	toggle_pause_menu()
