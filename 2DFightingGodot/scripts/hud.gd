extends Control
# Assets
const africanProfile = preload("res://assets/profiles/africa man profile.aesprite.png")
const chineseProfile = preload("res://assets/profiles/china profile.aesprite.png")
const japaneseProfile = preload("res://assets/profiles/japan man profile.aesprite.png")
const samoanProfile = preload("res://assets/profiles/samoan body profile.aesprite.png")
const vikingProfile = preload("res://assets/profiles/viking profile.aesprite.png")
const mexicnaProfile = preload("res://assets/profiles/Mexican-profile.png")
const heartAlive = preload("res://assets/Ui Assets/heart.png")
const heartDead = preload("res://assets/Ui Assets/heartdead.png")
# Nodes
@onready var global_script = $"/root/Global"
@onready var player1Label = $VBoxContainer/HBoxContainer/Player1/HP1
@onready var player2Label = $VBoxContainer/HBoxContainer/Player2/HP2
@onready var player1Icon = $VBoxContainer/HBoxContainer/Player1/Background/Icon1
@onready var player2Icon = $VBoxContainer/HBoxContainer/Player2/Background/Icon2
@onready var player1Health1 = $VBoxContainer/HBoxContainer/Player1/TopBorder/HBoxContainer/Heart1
@onready var player1Health2 = $VBoxContainer/HBoxContainer/Player1/TopBorder/HBoxContainer/Heart2
@onready var player1Health3 = $VBoxContainer/HBoxContainer/Player1/TopBorder/HBoxContainer/Heart3
@onready var player2Health1 = $VBoxContainer/HBoxContainer/Player2/TopBorder/HBoxContainer/Heart1
@onready var player2Health2 = $VBoxContainer/HBoxContainer/Player2/TopBorder/HBoxContainer/Heart2
@onready var player2Health3 = $VBoxContainer/HBoxContainer/Player2/TopBorder/HBoxContainer/Heart3
# Variables
var localPlayer1Health : int
var localPlayer2Health : int
var localPlayer1Lives : int
var localPlayer2Lives : int
	
func _process(_delta):
	localPlayer1Health = global_script.player1health
	localPlayer2Health = global_script.player2health
	localPlayer1Lives = global_script.globalPlayer1Lives
	localPlayer2Lives = global_script.globalPlayer1Lives
	player1Label.text = str(localPlayer1Health)
	player2Label.text = str(localPlayer2Health)
	if global_script.globalPlayer1Lives == 3:
		player1Health1.texture = heartAlive
		player1Health2.texture = heartAlive
		player1Health3.texture = heartAlive
	elif global_script.globalPlayer1Lives == 2:
		player1Health1.texture = heartAlive
		player1Health2.texture = heartAlive
		player1Health3.texture = heartDead
	elif global_script.globalPlayer1Lives == 1:
		player1Health1.texture = heartAlive
		player1Health2.texture = heartDead
		player1Health3.texture = heartDead
	elif global_script.globalPlayer1Lives == 0:
		player1Health1.texture = heartDead
		player1Health2.texture = heartDead
		player1Health3.texture = heartDead
		
	if global_script.globalPlayer2Lives == 3:
		player2Health1.texture = heartAlive
		player2Health2.texture = heartAlive
		player2Health3.texture = heartAlive
	elif global_script.globalPlayer2Lives == 2:
		player2Health1.texture = heartAlive
		player2Health2.texture = heartAlive
		player2Health3.texture = heartDead
	elif global_script.globalPlayer2Lives == 1:
		player2Health1.texture = heartAlive
		player2Health2.texture = heartDead
		player2Health3.texture = heartDead
	elif global_script.globalPlayer2Lives <= 0:
		player2Health1.texture = heartDead
		player2Health2.texture = heartDead
		player2Health3.texture = heartDead
	
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

