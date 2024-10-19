extends Control
# Nodes
@onready var settingsMenu = $"settings_menu"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/character_select.tscn")


func _on_settings_pressed():
	settingsMenu.visible = true


func _on_quit_pressed():
	get_tree().quit()
