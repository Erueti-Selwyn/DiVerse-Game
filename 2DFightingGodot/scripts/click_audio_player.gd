extends AudioStreamPlayer2D
@onready var global_script = $"/root/Global"


func click_button_effect():
	if global_script.sound_on:
		self.play()
