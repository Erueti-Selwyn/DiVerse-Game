extends Area2D

# Variables
var speed : int = 1400
var direction : int
var player_Index : int
var bullet_damage : int
var gunType : int = 1

func bulletspawn(dir : int, player : int, dam : int, type : int):
	direction = dir
	player_Index = player
	bullet_damage = dam
	gunType = type

func _physics_process(delta):
	move_local_x(speed * delta * direction)
	delete()
	#var move_vector = velocity.normalized() * speed * delta
	


func delete():
		await get_tree().create_timer(2).timeout
		queue_free()


func _on_area_entered(area):
	if area.is_in_group("player"):
		var grandparent = area.get_parent().get_parent()
		if grandparent.has_method("get_player_index"):
			var collided_player_index = grandparent.get_player_index()
			if player_Index != collided_player_index:
				if grandparent.has_method("bullet_hit"):
					grandparent.bullet_hit(direction, bullet_damage, gunType)
					queue_free()


func _on_body_entered(body):
	if body.is_in_group("tilemap"):
		queue_free()
