extends AudioStreamPlayer2D
@onready var global_script = $"/root/Global"
func play_button_effect():
	if global_script.sound_on:
		self.play()