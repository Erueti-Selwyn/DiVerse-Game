extends Node2D

var velocity = Vector2(0, 1)
var speed = 300

func _physics_process(delta):
	var move_vector = velocity.normalized() * speed * delta
	
	move_and_collide()

