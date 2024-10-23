extends AudioStreamPlayer2D
const MENU_MUSIC = preload("res://assets/audio/music/menu music.mp3")
@onready var global_script = $"/root/Global"


func _ready():
	self.stream = MENU_MUSIC
	self.stream.loop = true
	play_menu_music()


func play_menu_music():
	if (
		global_script.music_on
		and global_script.is_on_menu
		and not self.playing
	):
		self.play()


func stop_menu_music():
	self.stop()
