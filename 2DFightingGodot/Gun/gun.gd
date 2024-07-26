extends Area2D

#var velocity = Vector2(0, 1)
var speed = 800

func _physics_process(delta):
	move_local_x(speed * delta)
	#var move_vector = velocity.normalized() * speed * delta


