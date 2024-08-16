extends Control

@onready var global_script = $"/root/Global"
@onready var player1label = $"Player 1/Label"
@onready var player2label = $"Player 2/Label"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	player1label.text = str(global_script.get("player1health")) + " %"
	player2label.text = str(global_script.get("player2health")) + " %"
