extends Control
@onready var global_script = $"/root/Global"
@onready var exitButton = $MarginContainer/VBoxContainer/HBoxContainer4/Exitbutton
@onready var clickAudioPlayer = $"../ClickAudioPlayer"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_exitbutton_pressed():
	global_script.button_jump(exitButton)
	clickAudioPlayer.play()
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(0.1, 0.1), 0.1).set_ease(Tween.EASE_IN)
	await tween.finished
	self.visible = false
func open_menu():
	self.pivot_offset = Vector2(self.size / 2)
	scale = Vector2(0.1, 0.1)
	self.visible = true
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1), 0.1).set_ease(Tween.EASE_OUT)
