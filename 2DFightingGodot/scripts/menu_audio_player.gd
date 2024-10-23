extends AudioStreamPlayer2D
const MENU_MUSIC = preload("res://assets/audio/music/menu music.mp3")
@onready var global_script = $"/root/Global"
var playingMenuMusic : bool = false


func _ready():
	self.stream = MENU_MUSIC
	self.stream.loop = true
	if not self.playing:
		if global_script.music_on:
			playingMenuMusic = true
			play_menu_music()


func play_menu_music():
	if global_script.music_on:
		self.play()
		playingMenuMusic = true


func stop_menu_music():
	self.stop()
	playingMenuMusic = false


func is_menu_music_playing():
	return(playingMenuMusic)
