extends Node

@export var player1Controller = true
@export var player2Controller = true
@export var player1health = 0
@export var player2health = 0
@export var globalPlayerCharacter1 = 1
@export var globalPlayerCharacter2 = 1
@export var isPaused = false
@export var winningPlayer = 0
@export var globalPlayer1Lives = 0
@export var globalPlayer2Lives = 0
@export var crateNumber = 0
@export var mapType = 1
@export var soundOn = true
@export var musicOn = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func display_damage_number(value, position):
	var number = Label.new()
	number.global_position = position
	number.text = str(value)
	number.z_index= 5
	number.label_settings = LabelSettings.new()
	
	var color = "#FFF"
	number.label_settings.font_color = color
	number.label_settings.font_size = 18
	number.label_settings.outline_color = "#000"
	number.label_settings.outline_size = 1
	
	call_deferred("add_child", number)
	
	await number.resized
	number.pivot_offset = Vector2(number.size / 2)
	
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	#tween.tween_property(number, "position:y", number.position.y - 24, 0.25).set_ease(Tween.EASE_OUT)
	tween.tween_property(number, "position:y", number.position.y + 20, 0.5).set_ease(Tween.EASE_IN)
	tween.tween_property(number, "scale", Vector2.ZERO, 0.5).set_ease(Tween.EASE_IN)
	
	await tween.finished
	number.queue_free()
