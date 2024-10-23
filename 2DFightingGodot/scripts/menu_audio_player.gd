extends AudioStreamPlayer2D
const MENU_MUSIC = preload("res://assets/audio/music/menu music.mp3")
@onready var global_script = $"/root/Global"
var playing_menu_music : bool = false


func _ready():
	self.stream = MENU_MUSIC
	self.stream.loop = true
	if not self.playing:
		if (
			global_script.music_on
			and global_script.is_on_menu
		):
			playing_menu_music = true
			play_menu_music()


func play_menu_music():
	if (
		global_script.music_on
		and global_script):
		self.play()
		playing_menu_music = true


func stop_menu_music():
	self.stop()
	playing_menu_music = false


func is_menu_music_playing():
	return(playing_menu_music)
