extends Control
@onready var global_script = $"/root/Global"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_play_pressed():
	if !global_script.player1Controller && !global_script.player2Controller:
		print("Cannot Have 2 Keyboard Inputs!")
	else:
		get_tree().change_scene_to_file("res://scenes/Level.tscn")


func _on_settings_pressed():
	get_tree().change_scene_to_file("res://scenes/settings_menu.tscn")


func _on_quit_pressed():
	get_tree().quit()
