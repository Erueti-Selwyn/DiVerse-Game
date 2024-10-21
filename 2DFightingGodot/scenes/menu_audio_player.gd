extends AudioStreamPlayer2D
const menuMusic = preload("res://assets/audio/music/menu music.mp3")
@export var playMenuMusic : bool = false
var playingMenuMusic : bool = false
func _ready():
	self.stream = menuMusic
func _process(_delta):
	if playMenuMusic && !playingMenuMusic:
		playingMenuMusic = true
		self.play()
	elif !playMenuMusic:
		playingMenuMusic = false
		self.stop()
func play_menu_music():
	playMenuMusic = true
func stop_menu_music():
	playMenuMusic = false
