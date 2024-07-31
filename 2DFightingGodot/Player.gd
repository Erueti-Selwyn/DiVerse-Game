extends CharacterBody2D

const bulletPath = preload("res://Gun/bullet.tscn")
const MAX_SPEED = 300
const ACCELERATION = 60
const JUMP_HIGHT = 600
const GRAVITY = 30
const UP = Vector2(0, -1)
const WALL_SLIDE_ACCELERATION = 10
const MAX_WALL_SLIDE_SPEED = 40

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

var joy_jump_pressed = false

var isHoldingGun = false
var attacking = false

#var velocity = Vector2(0, 1)
var speed = 300

var direction
var direction_input
var facingRight = true
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var DEADZONE = 0.2
@export var player_index = 0
@onready var _animated_sprite = $AnimatedSprite2D


func _process(_delta):
	if isHoldingGun:
		if Input.is_joy_button_pressed(player_index, 2):
			shoot()
	else:
		if Input.is_joy_button_pressed(player_index, 2):
			attack()
	if velocity == Vector2(0, 0) && !attacking:
		_animated_sprite.play("idle")
	if is_on_floor() && !dashing && !attacking:
		if velocity.x > 0:
			_animated_sprite.play("walk")
		elif velocity.x < 0:
			_animated_sprite.play("walk")
	if !is_on_floor() && !attacking:
		_animated_sprite.play("jump")
	if is_on_wall() && !is_on_floor() && !attacking:
		_animated_sprite.play("wall")

	if velocity.x > 0:
		_animated_sprite.flip_h = false
		facingRight = true
	elif velocity.x < 0:
		_animated_sprite.flip_h = true
		facingRight = false
	
	# Detects Dash Input
	if Input.is_joy_button_pressed(player_index, 1):
		dash()

func _physics_process(delta):
	# Gets Controller Joystick Input
	direction_input = Input.get_joy_axis(player_index, 0)
	# Adds Deadzone
	if abs(direction_input) < DEADZONE:
		direction = 0
	else:
		direction = (direction_input - sign(direction_input) * DEADZONE) / (1 - DEADZONE)
	if dashing && !attacking:
			velocity.x = dashSpeed * dashDirection
	elif !attacking:
		if velocity.x > MAX_SPEED:
			velocity.x = MAX_SPEED
		elif velocity.x < -MAX_SPEED:
			velocity.x = -MAX_SPEED
		if direction != 0 && !dashing:
			velocity.x = velocity.x + (ACCELERATION * direction)
		else:
			velocity.x = move_toward(velocity.x, 0, MAX_SPEED)
	if attacking:
		velocity = Vector2.ZERO
			
	if Input.is_action_pressed("move_down"):
		crouching = true
		if is_on_floor():
			position.y += 1
	else:
		crouching = false

	if is_on_floor(): 
		dub_jumps = max_num_dub_jumps
		velocity.y = 0
	if Input.is_joy_button_pressed(player_index, 0) && !attacking:
		if !joy_jump_pressed:
			joy_jump_pressed = true
			if dub_jumps > 0: 
				dub_jumps -= 1
				velocity.y = -JUMP_HIGHT
			if is_on_wall() && direction == 1:
				velocity.x = -(MAX_SPEED * 3)
			elif is_on_wall() && direction == -1:
				velocity.x = (MAX_SPEED * 3)
	else:
		joy_jump_pressed = false

	if is_on_wall() && (direction == -1 || direction == 1) && !attacking:
		dub_jumps = max_num_dub_jumps
		if velocity.y >= 0: 
			velocity.y = min(velocity.y + WALL_SLIDE_ACCELERATION, MAX_WALL_SLIDE_SPEED)
		
		else:
			velocity.y += GRAVITY
	elif !is_on_floor() && !attacking:
		velocity.y += GRAVITY
		
	if dashing:
		velocity.y = 0
	if is_on_floor():
		currentDashAmount = dashAmount
	
	move_and_slide()
	
	
func shoot():
	var bullet = bulletPath.instantiate()
	if facingRight:
		bullet._direction(1)
	else:
		bullet._direction(-1)
	bullet.global_position = $Marker2D.global_position
	get_parent().add_child(bullet)

func dash():
	if !dashing:
		if facingRight:
			dashDirection = 1
		else:
			dashDirection = -1
	if currentDashAmount > 0 and !dashing and canDash:
		dashing = true
		canDash = false
		currentDashAmount -= 1
		await get_tree().create_timer(0.1).timeout
		dashing = false
		await get_tree().create_timer(0.5).timeout
		canDash = true
		
func attack():
	if !attacking:
		attacking = true
		_animated_sprite.play("attack")

func _on_area_2d_body_entered(body):
	var collided_script = body.get("player_index")
	if collided_script == player_index:
		position = Vector2(0, 0)
		velocity = Vector2(0, 0)

func _on_melee_body_entered(body):
	if body.is_in_group("player"):
		print("Hit Player")


func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "attack":
		attacking = false
