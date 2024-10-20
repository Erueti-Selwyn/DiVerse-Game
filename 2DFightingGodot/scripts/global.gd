extends Node
var menuScene = preload("res://scenes/menu.tscn")
var characterSelectScene = preload("res://scenes/character_select.tscn")
var levelScnee = preload("res://scenes/Level.tscn")
var winScene = preload("res://scenes/win.tscn")
# Global Variables
@export var player1Controller : bool = true
@export var player2Controller : bool = true
@export var player1health : int = 0
@export var player2health : int= 0
@export var globalPlayerCharacter1 : int = 1
@export var globalPlayerCharacter2 : int = 1
@export var isPaused : bool = false
@export var winningPlayer : int = 0
@export var globalPlayer1Lives : int = 0
@export var globalPlayer2Lives : int= 0
@export var crateNumber = 0
@export var mapType : int= 1
@export var soundOn : bool = true
@export var musicOn : bool = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

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

func menu_scene():
	get_tree().change_scene_to_packed(menuScene)
func character_select_scene():
	get_tree().change_scene_to_packed(characterSelectScene)
func level_scene():
	get_tree().change_scene_to_packed(levelScnee)
func win_scene():
	get_tree().change_scene_to_packed(winScene)
