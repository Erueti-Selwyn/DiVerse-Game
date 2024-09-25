extends Control
@onready var global_script = $"/root/Global"
@onready var player1label = $"Player 1/Label"
@onready var player2label = $"Player 2/Label"
@onready var colorrect1 = $"Player 1/ColorRect"
@onready var colorrect2 = $"Player 2/ColorRect"
var localplayer1health
var localplayer2health

var player1color
var player2color

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	localplayer1health = global_script.player1health
	localplayer2health = global_script.player2health
	player1label.text = str(localplayer1health) + " %"
	player2label.text = str(localplayer2health) + " %"


