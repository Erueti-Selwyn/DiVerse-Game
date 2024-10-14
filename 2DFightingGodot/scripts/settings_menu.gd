extends Control
const switchOn = preload("res://assets/Ui Assets/optionButtonOn.png")
const switchOff = preload("res://assets/Ui Assets/optionButtonOff.png")
const swtichOnMask = preload("res://assets/Ui Assets/optionButtonOnMask.png")
const swtichOffMask = preload("res://assets/Ui Assets/optionButtonOffMask.png")
@onready var global_script = $"/root/Global"
@onready var optionPlayerButton1 = $"MarginContainerPlayer1/VBoxContainer/OptionButtonPlayer1"
@onready var optionPlayerButton2 = $"MarginContainerPlayer2/VBoxContainer/OptionButtonPlayer2"

func _ready():
	localSoundOn = global_script.soundOn
	localMusicOn = global_script.musicOn
	
func _process(_delta):
	global_script.soundOn = localSoundOn
	global_script.musicOn = localMusicOn
func _on_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func _on_option_button_player_1_item_selected(input_type):
	if input_type == 0:
		global_script.player1Controller = true
	elif input_type == 1:
		global_script.player1Controller = false


func _on_option_button_player_2_item_selected(input_type):
	if input_type == 0:
		Global.player2Controller = true
	elif input_type == 1:
		Global.player2Controller = false


<<<<<<< HEAD
=======
func _on_controls_pressed():
	controlsMenu.visible = true
>>>>>>> parent of 6aaaab8 (Merge branch 'main' into Erueti)
