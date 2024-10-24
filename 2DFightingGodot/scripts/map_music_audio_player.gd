extends AudioStreamPlayer2D
const AFRICA_MUSIC = preload("res://assets/audio/music/africa.mp3")
const CHINA_MUSIC = preload("res://assets/audio/music/china map music.mp3")
const JAPAN_MUSIC = preload("res://assets/audio/music/japanese map music.mp3")
const MEXICO_MUSIC = preload("res://assets/audio/music/mexico map music.mp3")
const SAMOAN_MUSIC = preload("res://assets/audio/music/samoa map music.mp3")
const VIKING_MUSIC = preload("res://assets/audio/music/viking map music.mp3")
@onready var global_script = $"/root/Global"
@onready var map_musics_dict : Dictionary = {
	1 : AFRICA_MUSIC,
	2 : CHINA_MUSIC,
	3 : JAPAN_MUSIC,
	4 : SAMOAN_MUSIC,
	5 : VIKING_MUSIC,
	6 : MEXICO_MUSIC,
	}
func _ready():
	
	play_map_music()
func play_map_music():
	if (
		global_script.music_on
		and global_script.is_on_level
		and not self.playing
	):
		self.stream = map_musics_dict[global_script.map_type]
		self.stream.loop = true
		self.play()


func stop_map_music():
	if self.playing:
		self.stop()
