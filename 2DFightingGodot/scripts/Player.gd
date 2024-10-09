extends CharacterBody2D

const africanPistolSprite = preload("res://assets/guns/africanpistol.png")
const chinesePistolSprite = preload("res://assets/guns/chinesepistol.png")
const japanesePistolSprite = preload("res://assets/guns/japanesepistol.png")
const mexicanPistolSprite = preload("res://assets/guns/mexicanpistol.png")
const norwegianPistolSprite = preload("res://assets/guns/norwegianpistol.png")
const polynesianPistolSprite = preload("res://assets/guns/polynesianpistol.png")
const rocketLauncherSprite = preload("res://assets/guns/rocketlauncher.png")
const sniperSprite = preload("res://assets/guns/sniper.png")
const bulletPath = preload("res://scenes/bullet.tscn")
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

var currentweapon = 0
var shootCooldown = 0.3
var isHoldingGun = false
var attacking = false
var isHit = false

var canShoot = true

#var velocity = Vector2(0, 1)
var speed = 300
var knockback_strength = 150
var knockback_health = 1


var directionX
var directionY
var direction_inputX
var direction_inputY
var facingRight = true

var playerCharacter = 0

@export var DEADZONE = 0.2
@export var DEADZONEY = 0.9
@export var player_index = 1
@export var meleeDamage = 5
@export var gunDamage = 2
@export var rocketLauncherDamage = 10
@export var sniperDamage = 15
var player_controller_index
var playercontroller = true
@onready var _animated_sprite = $CollisionShape2D/AnimatedSprite2D
@onready var _attack_collision = $CollisionShape2D/AnimatedSprite2D/Melee/AttackCollision
@onready var global_script = $"/root/Global"
@onready var gunSprite = $"CollisionShape2D/AnimatedSprite2D/Gun"
@onready var playerLabel = $"Label"
func _ready():
	knockback_health = 100
	_attack_collision.disabled = true
	if player_index == 1:
		if global_script.player1Controller == true:
			player_controller_index = 0
			playercontroller = true
		elif global_script.player1Controller == false:
			playercontroller = false
	if player_index == 2:
		if global_script.player1Controller == false && global_script.player2Controller == true:
			player_controller_index = 0
		else:
			player_controller_index = 1
		if global_script.player2Controller == true:
			playercontroller = true

		elif global_script.player2Controller == false:
			playercontroller = false
	
	if player_index == 1:
		playerCharacter = global_script.globalPlayerCharacter1
	elif player_index == 2:
		playerCharacter = global_script.globalPlayerCharacter2
	playerLabel.text = "Player: " + str(player_index)
	if playerCharacter == 1:
		gunSprite.texture = africanPistolSprite
	elif playerCharacter == 2:
		gunSprite.texture = chinesePistolSprite
	elif playerCharacter == 3:
		gunSprite.texture = japanesePistolSprite
	elif playerCharacter == 4:
		gunSprite.texture = polynesianPistolSprite
	elif playerCharacter == 5:
		gunSprite.texture = norwegianPistolSprite
	elif playerCharacter == 6:
		gunSprite.texture = mexicanPistolSprite

func _physics_process(_delta):
	if global_script.isPaused == false:
		if Input.is_action_just_pressed("move_down"):
			if isHoldingGun:
				isHoldingGun = false
			else:
				isHoldingGun = true
		if knockback_health < 0:
			knockback_health = 0
		if player_index == 1:
			global_script.player1health = knockback_health
		elif player_index == 2:
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
		if playerCharacter == 3: # Japanese
			if velocity == Vector2(0, 0) && !attacking:
				_animated_sprite.play("japaneseidle")
			if is_on_floor() && !dashing && !attacking:
				if velocity.x > 0:
					_animated_sprite.play("japanesewalk")
				elif velocity.x < 0:
					_animated_sprite.play("japanesewalk")
			if !is_on_floor() && !attacking:
				_animated_sprite.play("japanesejump")
			if is_on_wall() && !is_on_floor() && !attacking:
				_animated_sprite.play("japanesewall")
		if playerCharacter == 6: # Mexican
			if velocity == Vector2(0, 0) && !attacking:
				_animated_sprite.play("mexicanidle")
			if is_on_floor() && !dashing && !attacking:
				if velocity.x > 0:
					_animated_sprite.play("mexicanwalk")
				elif velocity.x < 0:
					_animated_sprite.play("mexicanwalk")
			if !is_on_floor() && !attacking:
				_animated_sprite.play("mexicanjump")
			if is_on_wall() && !is_on_floor() && !attacking:
				_animated_sprite.play("mexicanwall")
		

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
		elif !isHit && directionX != 0 && !dashing && !attacking:
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
	if canShoot:
		var bullet = bulletPath.instantiate()
		if facingRight:
			bullet.bulletspawn(1, player_index, gunDamage)
		else:
			bullet.bulletspawn(-1, player_index, gunDamage)
		bullet.global_position = $CollisionShape2D/AnimatedSprite2D/Marker2D.global_position
		get_parent().add_child(bullet)
		canShoot = false
		await get_tree().create_timer(shootCooldown).timeout
		canShoot = true

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
		gunSprite.hide()
		_attack_collision.disabled = false
		attacking = true
		_animated_sprite.play("attack")
	

func _on_melee_body_entered(body):
	if body.is_in_group("player"):
		body.is_hit(global_position, meleeDamage)

func is_hit(attacker_position, damage_done):
	var knockback_direction = global_position - attacker_position
	knockback_health = knockback_health - damage_done
	if knockback_direction.x > 0:
		velocity.x = velocity.x + (knockback_strength * damage_done + 25 * ((100 - knockback_health) + 1))
	elif knockback_direction.x < 0:
		velocity.x = velocity.x - (knockback_strength * damage_done + 25 * ((100 - knockback_health) + 1))
	isHit = true
	_animated_sprite.modulate = Color(1, 0, 0) 
	await get_tree().create_timer(0.15).timeout
	isHit = false
	_animated_sprite.modulate = Color(1, 1, 1)
	

func _on_animated_sprite_2d_animation_finished():
	if $CollisionShape2D/AnimatedSprite2D.animation == "attack":
		gunSprite.show()
		_attack_collision.disabled = true
		attacking = false


func _on_area_2d_area_entered(area):
	if area.is_in_group("boundary"):
		position = Vector2(0, 0)
		velocity = Vector2(0, 0)
		
func get_player_index():
	return(player_index)

func bullet_hit(bullet_direction, damage_done):
	var knockback_direction = bullet_direction
	knockback_health = knockback_health - damage_done
	if knockback_direction > 0:
		velocity.x = velocity.x + (knockback_strength * damage_done + 25 * ((100 - knockback_health) + 1))
	elif knockback_direction < 0:
		velocity.x = velocity.x - (knockback_strength * damage_done + 25 * ((100 - knockback_health) + 1))
	isHit = true
	_animated_sprite.modulate = Color(1, 0, 0) 
	await get_tree().create_timer(0.15).timeout
	isHit = false
	_animated_sprite.modulate = Color(1, 1, 1)
