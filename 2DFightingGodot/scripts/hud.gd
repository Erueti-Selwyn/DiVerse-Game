extends Control
const africanProfile = preload("res://assets/profiles/africa man profile.aesprite.png")
const chineseProfile = preload("res://assets/profiles/china profile.aesprite.png")
const japaneseProfile = preload("res://assets/profiles/japan man profile.aesprite.png")
const samoanProfile = preload("res://assets/profiles/samoan body profile.aesprite.png")
const vikingProfile = preload("res://assets/profiles/viking profile.aesprite.png")
const mexicnaProfile = preload("res://assets/profiles/Mexican-profile.png")

@onready var global_script = $"/root/Global"
@onready var player1label = $VBoxContainer/HBoxContainer/Control/HP1
@onready var player2label = $VBoxContainer/HBoxContainer/Control2/HP2
@onready var player1Icon = $VBoxContainer/HBoxContainer/Control/Background/Icon1
@onready var player2Icon = $VBoxContainer/HBoxContainer/Control2/Background/Icon2
var localplayer1health
var localplayer2health

var player1color
var player2color
	
func _process(_delta):
	localplayer1health = global_script.player1health
	localplayer2health = global_script.player2health
	player1label.text = str(localplayer1health)
	player2label.text = str(localplayer2health)
	
	if global_script.globalPlayerCharacter1 == 1:
		player1Icon.texture = africanProfile
	elif global_script.globalPlayerCharacter1 == 2:
		player1Icon.texture = chineseProfile
	elif global_script.globalPlayerCharacter1 == 3:
		player1Icon.texture = japaneseProfile
	elif global_script.globalPlayerCharacter1 == 4: 
		player1Icon.texture = samoanProfile
	elif global_script.globalPlayerCharacter1 == 5:
		player1Icon.texture = vikingProfile
	elif global_script.globalPlayerCharacter1 == 6:
		player1Icon.texture = mexicnaProfile

	if global_script.globalPlayerCharacter2 == 1:
		player2Icon.texture = africanProfile
	elif global_script.globalPlayerCharacter2 == 2:
		player2Icon.texture = chineseProfile
	elif global_script.globalPlayerCharacter2 == 3:
		player2Icon.texture = japaneseProfile
	elif global_script.globalPlayerCharacter2 == 4: 
		player2Icon.texture = samoanProfile
	elif global_script.globalPlayerCharacter2 == 5:
		player2Icon.texture = vikingProfile
	elif global_script.globalPlayerCharacter2 == 6:
		player2Icon.texture = mexicnaProfile

