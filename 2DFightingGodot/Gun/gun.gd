extends Area2D

#var velocity = Vector2(0, 1)
var speed = 1200
var direction = 1

func _direction(dir):
	direction = dir


func _physics_process(delta):
	move_local_x(speed * delta * direction)
	delete()
	#var move_vector = velocity.normalized() * speed * delta
	


func delete():
		await get_tree().create_timer(2).timeout
		queue_free()
