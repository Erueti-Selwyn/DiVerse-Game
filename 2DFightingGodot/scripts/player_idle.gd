extends Node2D
@onready var global_script = $"/root/Global"
@onready var _animated_sprite = $AnimatedSprite2D
@export var winner = false
# Called when the node enters the scene tree for the first time.
func _ready():
	if winner:
		if global_script.winningPlayer == 1:
			if global_script.globalPlayerCharacter1 == 1:
				_animated_sprite.play("africanIdle")
			elif global_script.globalPlayerCharacter1 == 2:
				_animated_sprite.play("chinaIdle")
			elif global_script.globalPlayerCharacter1 == 3:
				_animated_sprite.play("japaneseIdle")
			elif global_script.globalPlayerCharacter1 == 4:
				_animated_sprite.play("samoanIdle")
			elif global_script.globalPlayerCharacter1 == 5:
				_animated_sprite.play("vikingIdle")
			elif global_script.globalPlayerCharacter1 == 6:
				_animated_sprite.play("mexicanIdle")
		if global_script.winningPlayer == 2:
			if global_script.globalPlayerCharacter2 == 1:
				_animated_sprite.play("africanIdle")
			elif global_script.globalPlayerCharacter2 == 2:
				_animated_sprite.play("chinaIdle")
			elif global_script.globalPlayerCharacter2 == 3:
				_animated_sprite.play("japaneseIdle")
			elif global_script.globalPlayerCharacter2 == 4:
				_animated_sprite.play("samoanIdle")
			elif global_script.globalPlayerCharacter2 == 5:
				_animated_sprite.play("vikingIdle")
			elif global_script.globalPlayerCharacter2 == 6:
				_animated_sprite.play("mexicanIdle")
	elif !winner:
		if global_script.winningPlayer == 2:
			if global_script.globalPlayerCharacter1 == 1:
				_animated_sprite.play("africanIdle")
			elif global_script.globalPlayerCharacter1 == 2:
				_animated_sprite.play("chinaIdle")
			elif global_script.globalPlayerCharacter1 == 3:
				_animated_sprite.play("japaneseIdle")
			elif global_script.globalPlayerCharacter1 == 4:
				_animated_sprite.play("samoanIdle")
			elif global_script.globalPlayerCharacter1 == 5:
				_animated_sprite.play("vikingIdle")
			elif global_script.globalPlayerCharacter1 == 6:
				_animated_sprite.play("mexicanIdle")
		if global_script.winningPlayer == 1:
			if global_script.globalPlayerCharacter2 == 1:
				_animated_sprite.play("africanIdle")
			elif global_script.globalPlayerCharacter2 == 2:
				_animated_sprite.play("chinaIdle")
			elif global_script.globalPlayerCharacter2 == 3:
				_animated_sprite.play("japaneseIdle")
			elif global_script.globalPlayerCharacter2 == 4:
				_animated_sprite.play("samoanIdle")
			elif global_script.globalPlayerCharacter2 == 5:
				_animated_sprite.play("vikingIdle")
			elif global_script.globalPlayerCharacter2 == 6:
				_animated_sprite.play("mexicanIdle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
