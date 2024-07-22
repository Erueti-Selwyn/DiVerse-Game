extends CharacterBody2D


const MAX_SPEED = 500
const ACCELERATION = 85
const JUMP_HIGHT = 600
const WALL_SLIDE_ACCELERATION = 10
const MAX_WALL_SLIDE_SPEED = 120

const GRAVITY = 1080
const CROUCH_GRAVITY = 2340
var CURRENT_GRAVITY = 1080

var jump_was_pressed = false
var can_jump = false
var isGravity = true
var dub_jumps = 0
var max_num_dub_jumps = 3 

var crouching = false

var PLAYER_DIRECTION = "right"
var DASH_DIRECTION = "right"
var dashAmount = 1
var currentDashAmount = 0
var canDash = true
var dashing = false
var dashSpeed = 1700
var is_punching = false

var facing_right = true


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var _animated_sprite = $AnimatedSprite2D

func _ready():
	pass

func _physics_process(delta):
	# Animation
	if velocity == Vector2(0, 0) && !is_punching:
		_animated_sprite.play("idlebase_ani")
	
	if Input.is_action_just_released("attack") && !is_punching:
		is_punching = true
		_animated_sprite.play("punch")
		await get_tree().create_timer(0.4).timeout
		print("finish")
		is_punching = false
		
	# Player Direction
	var direction = Input.get_axis("move_left", "move_right")
	if Input.is_action_pressed("move_left") && !Input.is_action_pressed("move_right"):
		PLAYER_DIRECTION = "left"
	elif Input.is_action_pressed("move_right") && !Input.is_action_pressed("move_left"):
		PLAYER_DIRECTION = "right"
	
	if direction and !dashing:
		velocity.x = velocity.x + (direction * ACCELERATION)
	else:
		velocity.x = move_toward(velocity.x, 0, ACCELERATION)
	
	# Capping Velocity
	if velocity.x > MAX_SPEED && !dashing:
		velocity.x = MAX_SPEED
	elif velocity.x < -MAX_SPEED && !dashing:
		velocity.x = -MAX_SPEED
	
	# Flipping Sprite
	if Input.is_action_pressed("move_right") && !is_punching:
		if !facing_right:
			facing_right = true
			scale.x = -1
	elif Input.is_action_pressed("move_left") && !is_punching:
		if facing_right:
			facing_right = false
			scale.x = -1
	
	# Move Through One Way
	if Input.is_action_pressed("move_down"):
		crouching = true
		if is_on_floor():
			position.y += 1
		else:
			CURRENT_GRAVITY = CROUCH_GRAVITY
	else:
		crouching = false
		CURRENT_GRAVITY = GRAVITY
	
	# Resets Jumps And Velocity When On The Floor
	if is_on_floor(): 
		dub_jumps = max_num_dub_jumps
		can_jump = true
		velocity.y = 0
	
	# Jump And Wall Jumps
	if Input.is_action_just_pressed("jump"):
		if can_jump == true && dub_jumps > 0 && !crouching: 
			dub_jumps -= 1 
			velocity.y = -JUMP_HIGHT
			if is_on_wall() && Input.is_action_pressed("move_right"):
				velocity.x = -MAX_SPEED 
			elif is_on_wall() && Input.is_action_pressed("move_left"):
				velocity.x = MAX_SPEED
	
	# Detects If On Wall
	if is_on_wall() && (Input.is_action_pressed("move_right") || Input.is_action_pressed("move_left")):
		can_jump = true
		currentDashAmount = dashAmount
		dub_jumps = max_num_dub_jumps
		if velocity.y >= 0: 
			velocity.y = min(velocity.y + WALL_SLIDE_ACCELERATION, MAX_WALL_SLIDE_SPEED)
		else:
			velocity.y += CURRENT_GRAVITY * delta
	elif !is_on_floor():
		# Adds Gravity
		velocity.y += CURRENT_GRAVITY * delta

	move_and_slide()
	dash()
		
func dash():
		
	
	if Input.is_action_just_pressed("dash") and currentDashAmount > 0 and !dashing and canDash and !is_punching and velocity.x != 0:
		DASH_DIRECTION = PLAYER_DIRECTION
		dashing = true
		canDash = false
		currentDashAmount -= 1
		await get_tree().create_timer(0.1).timeout
		dashing = false
		await get_tree().create_timer(0.5).timeout
		canDash = true

	if dashing:
		if DASH_DIRECTION == "left":
			velocity.x = -dashSpeed
		if DASH_DIRECTION == "right":
			velocity.x = dashSpeed
		
	if is_on_floor():
		currentDashAmount = dashAmount

func _on_area_2d_body_entered(body):
	if body.is_in_group("boundary"):
		position = Vector2(0, 0)
		print("Hit Boundary")
