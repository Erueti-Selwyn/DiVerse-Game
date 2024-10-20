extends Control
@onready var global_script = $"/root/Global"
@onready var exitButton = $MarginContainer/VBoxContainer/HBoxContainer4/Exitbutton
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_exitbutton_pressed():
	global_script.button_jump(exitButton)
	await get_tree().create_timer(0.05).timeout
	self.visible = false
