extends Node2D
@onready var global_script = $"/root/Global"
@onready var _animated_sprite = $AnimatedSprite2D
@export var winner : bool = false
@export var characterSelect : bool
@export var player1 : bool = false

var animation_map : Dictionary = {
	1 : "africanIdle",
	2 : "chinaIdle",
	3 : "japaneseIdle",
	4 : "samoanIdle",
	5 : "vikingIdle",
	6 : "mexicanIdle",
}
# Called when the node enters the scene tree for the first time.
func _ready():
	if winner:
		if global_script.winningPlayer == 1:
			_animated_sprite.play(animation_map[global_script.globalPlayerCharacter1])
		if global_script.winningPlayer == 2:
			_animated_sprite.play(animation_map[global_script.globalPlayerCharacter2])
	elif !winner:
		if global_script.winningPlayer == 2:
			_animated_sprite.play(animation_map[global_script.globalPlayerCharacter1])
		if global_script.winningPlayer == 1:
			_animated_sprite.play(animation_map[global_script.globalPlayerCharacter2])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if characterSelect:
		if player1:
			_animated_sprite.play(animation_map[global_script.globalPlayerCharacter1])
		else:
			_animated_sprite.play(animation_map[global_script.globalPlayerCharacter2])
