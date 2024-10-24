extends Node
# Preload Large Scnee to Reduce Lag
var character_select_scene = preload("res://scenes/character_select.tscn")
var level_scene = preload("res://scenes/Level.tscn")
# Global Variables
@export var player_1_controller : bool = false
@export var player_2_controller : bool = false
@export var player_1_health : int = 0
@export var player_2_health : int= 0
@export var global_player_character_1 : int = 1
@export var global_player_character_2 : int = 1
@export var is_paused : bool = false
@export var winning_player : int = 0
@export var global_player_1_lives : int = 0
@export var global_player_2_lives : int= 0
@export var crate_number = 0
@export var map_type : int = 1
@export var sound_on : bool = true
@export var music_on : bool = true
@export var is_on_menu : bool = true
@export var is_on_level : bool = false


func display_damage_number(value : int, position : Vector2):
	var number = Label.new()
	number.global_position = position
	number.text = str(value)
	number.z_index= 5
	number.label_settings = LabelSettings.new()
	var color = Color(1, 1, 1)
	number.label_settings.font_color = color
	number.label_settings.font_size = 18
	number.label_settings.outline_color = "#000"
	number.label_settings.outline_size = 1
	call_deferred("add_child", number)
	await number.resized
	number.pivot_offset = Vector2(number.size / 2)
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(number, "position:y", number.position.y + 20, 0.5).set_ease(Tween.EASE_IN)
	tween.tween_property(number, "scale", Vector2.ZERO, 0.5).set_ease(Tween.EASE_IN)
	tween.tween_property(number, "modulate", Color(1, 0, 0), 0.5).set_ease(Tween.EASE_IN)
	await tween.finished
	number.queue_free()


func button_jump(button):
	button.pivot_offset = Vector2(button.size / 2)
	var tween = get_tree().create_tween()
	tween.set_parallel(false)
	tween.tween_property(button, "scale", Vector2(1.05, 1.05), 0.05).set_ease(Tween.EASE_IN)
	tween.tween_property(button, "scale", Vector2(1, 1), 0.05).set_ease(Tween.EASE_IN)


func load_menu_scene():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")


func load_character_select_scene():
	get_tree().change_scene_to_packed(character_select_scene)


func load_level_scene():
	get_tree().change_scene_to_packed(level_scene)


func load_win_scene():
	get_tree().change_scene_to_file("res://scenes/win.tscn")
