extends Area2D
@onready var global_script = $"/root/Global"
# Variables
var speed : int = 1400
var direction : int
var player_index : int
var bullet_damage : int
var gun_type : int = 1


func _ready():
	delete()


func bullet_spawn(dir : int, player : int, dam : int, type : int):
	# Sets Variable for new bullet.
	direction = dir
	player_index = player
	bullet_damage = dam
	gun_type = type


func _physics_process(delta):
	# Adds velocity.
	if !global_script.is_paused:
		move_local_x(speed * delta * direction)


func delete():
	# Deletes after 2 seconds
	await get_tree().create_timer(2).timeout
	queue_free()


func _on_area_entered(area):
	# Checks if bullet hit player.
	if area.is_in_group("player"):
		# Gets player script.
		var grandparent = area.get_parent().get_parent()
		if grandparent.has_method("get_player_index"):
			var collided_player_index = grandparent.get_player_index()
			if player_index != collided_player_index:
				if grandparent.has_method("bullet_hit"):
					# Calls bullet hit function.
					grandparent.bullet_hit(direction, bullet_damage, gun_type)
					queue_free()


func _on_body_entered(body):
	# Destroys if hits tilemap.
	if body.is_in_group("tilemap"):
		queue_free()
