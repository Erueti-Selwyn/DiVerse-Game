extends Control
@onready var global_script = $"/root/Global"
@onready var global_click_audio_player = $"/root/ClickAudioPlayer"
@onready var exit_button = $MarginContainer/VBoxContainer/HBoxContainer4/Exitbutton


func _on_exitbutton_pressed():
	global_script.button_jump(exit_button)
	global_click_audio_player.click_button_effect()
	# Adds closing controls menu animation.
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(0.1, 0.1), 0.1).set_ease(Tween.EASE_IN)
	await tween.finished
	self.visible = false


func open_menu():
	# Adds opening menu animation.
	self.pivot_offset = Vector2(self.size / 2)
	scale = Vector2(0.1, 0.1)
	self.visible = true
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1), 0.1).set_ease(Tween.EASE_OUT)
