extends CharacterBody2D

const bulletPath = preload("res://Gun/bullet.tscn")
const MAX_SPEED = 200
const ACCELERATION = 100

const JUMP_HIGHT = 600
const GRAVITY = 30
const UP = Vector2(0, -1)
const WALL_SLIDE_ACCELERATION = 10
const MAX_WALL_SLIDE_SPEED = 120
const bulletPath = preload("res://Gun/bullet.tscn")

var jump_was_pressed = false
var can_jump = false
var isGravity = true
var dub_jumps = 0
var max_num_dub_jumps = 3 

var normalSpeed = 450
var crouchSpeed = 300
var crouching = false

var dashDirection = Vector2(0, 0)
var dashAmount = 1
var currentDashAmount = 0
var canDash = true
var dashing = false
var dashSpeed = 1700

#var velocity = Vector2(0, 1)
var speed = 300



# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var _animated_sprite = $AnimatedSprite2D

func _ready():
	pass
	
	

func _process(_delta):
	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot():
	var bullet = bulletPath.instantiate()
	bullet.global_position = $Marker2D.global_position
	get_parent().add_child(bullet)

func _physics_process(delta):
	var move_vector = velocity.normalized() * speed * delta
	
	move_and_slide()
	
	if velocity == Vector2(0, 0):
		_animated_sprite.play("idlebase_ani")
	else:
		_animated_sprite.stop()
	var direction = Input.get_axis("move_left", "move_right")
	if Input.is_action_just_pressed("dash") and !dashing:
		dashDirection = direction
	if dashing:
		velocity.x = dashDirection * dashSpeed
	else:
		if direction and !dashing:
			velocity.x = direction * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
			
	if Input.is_action_pressed("move_down"):
		crouching = true
		if is_on_floor():
			position.y += 1
	else:
		crouching = false
	if is_on_floor(): 
		dub_jumps = max_num_dub_jumps
		can_jump = true
		velocity.y = 0
	if Input.is_action_just_pressed("jump"):
		if can_jump == true && dub_jumps > 0: 
			dub_jumps -= 1 
			velocity.y = -JUMP_HIGHT
			if is_on_wall() && Input.is_action_pressed("move_right"):
				velocity.x = -MAX_SPEED 
			elif is_on_wall() && Input.is_action_pressed("move_left"):
				velocity.x = MAX_SPEED
			
	
	
	
	
	
	if is_on_wall() && (Input.is_action_pressed("move_right") || Input.is_action_pressed("move_left")):
		can_jump = true
		dub_jumps = max_num_dub_jumps
		if velocity.y >= 0: 
			velocity.y = min(velocity.y + WALL_SLIDE_ACCELERATION, MAX_WALL_SLIDE_SPEED)
		
		else:
			velocity.y += GRAVITY
	elif !is_on_floor():
		velocity.y += GRAVITY
	
	
		
	move_and_slide()
	dash()
		
func dash():
	if dashing:
		velocity.y = 0
	if is_on_floor():
		currentDashAmount = dashAmount
		
	if Input.is_action_just_pressed("dash") and currentDashAmount > 0 and !dashing and canDash:
		dashing = true
		canDash = false
		currentDashAmount -= 1
		await get_tree().create_timer(0.1).timeout
		dashing = false
		await get_tree().create_timer(0.5).timeout
		canDash = true
		
		


func _on_area_2d_body_entered(body):
	if body.is_in_group("boundary"):
		position = Vector2(0, 0)
		print("Hit Boundary")
