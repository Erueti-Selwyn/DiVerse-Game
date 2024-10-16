extends Area2D

#var velocity = Vector2(0, 1)
var speed = 1400
var direction = 1
var player_Index = 0
var bullet_damage = 2

func bulletspawn(dir, player, dam):
	direction = dir
	player_Index = player
	bullet_damage = dam

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
					grandparent.bullet_hit(direction, bullet_damage)
					queue_free()
