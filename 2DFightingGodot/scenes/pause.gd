extends Control
@onready var global_script = $"/root/Global"
var paused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pauseMenu()

func pauseMenu():
	if paused:
		self.hide()
		Engine.time_scale = 1
		global_script.isPaused = false
	else:
		self.show()
		Engine.time_scale = 0
		global_script.isPaused = true
	paused = !paused

func _on_resume_pressed():
	pauseMenu()


func _on_quit_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
	pauseMenu()