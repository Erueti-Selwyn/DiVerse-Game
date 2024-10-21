extends AudioStreamPlayer2D
const menuMusic = preload("res://assets/audio/music/menu music.mp3")
var playingMenuMusic : bool = false
func _ready():
	self.stream = menuMusic
	self.stream.loop = true
	if not self.playing:
		playingMenuMusic = true
		play_menu_music()
func play_menu_music():
	self.play()
	playingMenuMusic = true
func stop_menu_music():
	self.stop()
	playingMenuMusic = false
func is_menu_music_playing():
	return(playingMenuMusic)
