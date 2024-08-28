extends CharacterBody2D

const bulletPath = preload("res://Gun/bullet.tscn")
const MAX_SPEED = 600
const ACCELERATION = 120
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

var MAX_FRICTION = 300
var FRICTION = 60

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
var isHit = false

#var velocity = Vector2(0, 1)
var speed = 300
var damage = 2
var knockback_strength = 50
var knockback_health = 1


var directionX
var directionY
var direction_inputX
var direction_inputY
var facingRight = true
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var DEADZONE = 0.2
@export var DEADZONEY = 0.9
@export var player_index = 0
var player_controller_index
var playercontroller = true
@onready var _animated_sprite = $CollisionShape2D/AnimatedSprite2D
@onready var _attack_collision = $CollisionShape2D/AnimatedSprite2D/Melee/AttackCollision
@onready var global_script = $"/root/Global"
func _ready():
	knockback_health = 100
	_attack_collision.disabled = true
	if player_index == 0:
		if global_script.player1Controller == true:
			player_controller_index = 0
			playercontroller = true
		elif global_script.player1Controller == false:
			playercontroller = false
	if player_index == 1:
		if global_script.player1Controller == false && global_script.player2Controller == true:
			player_controller_index = 0
		else:
			player_controller_index = 1
		if global_script.player2Controller == true:
			playercontroller = true

		elif global_script.player2Controller == false:
			playercontroller = false

		
func _process(_delta):
	if Input.is_action_just_pressed("move_down"):
		if isHoldingGun:
			isHoldingGun = false
		else:
			isHoldingGun = true
	if knockback_health < 0:
		knockback_health = 0
	if player_index == 0:
		global_script.player1health = knockback_health
	elif player_index == 1:
		global_script.player2health = knockback_health
		
	if playercontroller:
		if isHoldingGun:
			if Input.is_joy_button_pressed(player_controller_index, 2):
				shoot()
		else:
			if Input.is_joy_button_pressed(player_controller_index, 2):
				attack()
	else:
		if isHoldingGun:
			if Input.is_action_just_pressed("shoot"):
				shoot()
		else:
			if Input.is_action_just_pressed("shoot"):
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
		_animated_sprite.scale.x = 1
		facingRight = true
	elif velocity.x < 0:
		_animated_sprite.scale.x = -1
		facingRight = false
	
	# Detects Dash Input
	if playercontroller:
		if Input.is_joy_button_pressed(player_controller_index, 1):
			dash()
	else:
		if Input.is_action_just_pressed("dash"):
			dash()

func _physics_process(_delta):
	# Gets Controller Joystick Input
	if playercontroller:
		direction_inputX = Input.get_joy_axis(player_controller_index, 0)
	else:
		direction_inputX = Input.get_axis("move_left", "move_right")
	# Adds Deadzone
	if abs(direction_inputX) < DEADZONE:
		directionX = 0
	else:
		directionX = (direction_inputX - sign(direction_inputX) * DEADZONE) / (1 - DEADZONE)
	if dashing && !isHit:
			velocity.x = dashSpeed * dashDirection
	elif !isHit && directionX != 0 && !dashing:
		velocity.x = velocity.x + (ACCELERATION * directionX)
			
	if velocity.x > MAX_SPEED:
		velocity.x = move_toward(velocity.x, 0, MAX_FRICTION)
	elif velocity.x < -MAX_SPEED:
		velocity.x = move_toward(velocity.x, 0, MAX_FRICTION)
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION)
	if playercontroller:
		direction_inputY = Input.get_joy_axis(player_controller_index, 1)
		if abs(direction_inputY) < DEADZONEY:
			directionY = 0
		else:
			directionY = (direction_inputY - sign(direction_inputY) * DEADZONEY) / (1 - DEADZONEY)
		if directionY > 0:
			crouching = true
			if is_on_floor():
				position.y += 1
		else:
			crouching = false
	else:
		if Input.is_action_pressed("move_down"):
			crouching = true
			if is_on_floor():
				position.y += 1
		else:
			crouching = false

	if is_on_floor(): 
		dub_jumps = max_num_dub_jumps
		velocity.y = 0
	if playercontroller:
		if Input.is_joy_button_pressed(player_controller_index, 0) && !attacking:
			if !joy_jump_pressed:
				joy_jump_pressed = true
				if dub_jumps > 0: 
					dub_jumps -= 1
					velocity.y = -JUMP_HIGHT
				if is_on_wall() && directionX == 1:
					velocity.x = -(MAX_SPEED * 3)
				elif is_on_wall() && directionX == -1:
					velocity.x = (MAX_SPEED * 3)
		else:
			joy_jump_pressed = false
	else:
		if Input.is_action_just_pressed("jump") && !attacking:
			if !joy_jump_pressed:
				joy_jump_pressed = true
				if dub_jumps > 0: 
					dub_jumps -= 1
					velocity.y = -JUMP_HIGHT
				if is_on_wall() && directionX == 1:
					velocity.x = -(MAX_SPEED * 3)
				elif is_on_wall() && directionX == -1:
					velocity.x = (MAX_SPEED * 3)
		else:
			joy_jump_pressed = false
	
	if attacking:
		velocity.x = 0
	
	if is_on_wall() && (directionX == -1 || directionX == 1) && !attacking:
		dub_jumps = max_num_dub_jumps
		if velocity.y >= 0: 
			velocity.y = min(velocity.y + WALL_SLIDE_ACCELERATION, MAX_WALL_SLIDE_SPEED)
		
		else:
			velocity.y += GRAVITY
	elif !is_on_floor():
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
	if !attacking && !isHit:
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
	if !attacking && !dashing:
		_attack_collision.disabled = false
		attacking = true
		_animated_sprite.play("attack")
	

func _on_melee_body_entered(body):
	if body.is_in_group("player"):
		body.is_hit(global_position, damage)

func is_hit(attacker_position, damage_done):
	var knockback_direction = global_position - attacker_position
	knockback_health = knockback_health - damage_done
	if knockback_direction.x > 0:
		velocity.x = velocity.x + knockback_strength * ((100 - knockback_health) + 1) 
	elif knockback_direction.x < 0:
		velocity.x = velocity.x - knockback_strength * ((100 - knockback_health) + 1) 
	isHit = true
	_animated_sprite.modulate = Color(1, 0, 0) 
	await get_tree().create_timer(0.15).timeout
	isHit = false
	_animated_sprite.modulate = Color(1, 1, 1)
	

func _on_animated_sprite_2d_animation_finished():
	if $CollisionShape2D/AnimatedSprite2D.animation == "attack":
		_attack_collision.disabled = true
		attacking = false


func _on_area_2d_area_entered(area):
	if area.is_in_group("boundary"):
		print("boundary")
		position = Vector2(0, 0)
		velocity = Vector2(0, 0)
