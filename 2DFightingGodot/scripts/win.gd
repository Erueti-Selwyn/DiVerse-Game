extends Node
@onready var global_script = $"/root/Global"
@onready var winnerTitle = $HBoxContainer/VBoxContainer/Label
# Called when the node enters the scene tree for the first time.
func _ready():
	winnerTitle.text = "Player "  + str(global_script.winningPlayer) + " Wins!"
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_menu_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
