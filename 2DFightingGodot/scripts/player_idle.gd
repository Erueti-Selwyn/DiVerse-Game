extends Node2D
# Nodes
@onready var global_script = $"/root/Global"
@onready var animated_sprite = $AnimatedSprite2D
# Variables
@export var winner : bool = false
@export var character_select : bool
@export var is_player_1 : bool = false
# Dictionary
var animation_map_dict : Dictionary = {
	1 : "africanIdle",
	2 : "chinaIdle",
	3 : "japaneseIdle",
	4 : "samoanIdle",
	5 : "vikingIdle",
	6 : "mexicanIdle",
}


func _ready():
	# If is on winner menu.
	if winner:
		if global_script.winning_player == 1:
			animated_sprite.play(animation_map_dict[global_script.global_player_character_1])
		if global_script.winning_player == 2:
			animated_sprite.play(animation_map_dict[global_script.global_player_character_2])
	elif !winner:
		if global_script.winning_player == 2:
			animated_sprite.play(animation_map_dict[global_script.global_player_character_1])
		if global_script.winning_player == 1:
			animated_sprite.play(animation_map_dict[global_script.global_player_character_2])


func _process(_delta):
	# If on character select menu.
	if character_select:
		if is_player_1:
			animated_sprite.play(animation_map_dict[global_script.global_player_character_1])
		else:
			animated_sprite.play(animation_map_dict[global_script.global_player_character_2])
