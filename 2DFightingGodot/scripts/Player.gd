extends CharacterBody2D

@export var player_index = 1

const africanPistolSprite = preload("res://assets/guns/africanpistol.png")
const chinesePistolSprite = preload("res://assets/guns/chinesepistol.png")
const japanesePistolSprite = preload("res://assets/guns/japanesepistol.png")
const mexicanPistolSprite = preload("res://assets/guns/mexicanpistol.png")
const norwegianPistolSprite = preload("res://assets/guns/norwegianpistol.png")
const polynesianPistolSprite = preload("res://assets/guns/polynesianpistol.png")
const rocketLauncherSprite = preload("res://assets/guns/rocketlauncher.png")
const sniperSprite = preload("res://assets/guns/sniper.png")
const bulletPath = preload("res://scenes/bullet.tscn")
const MAX_SPEED = 450
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

var MAX_FRICTION = 225
var FRICTION = 30

var dashDirection = Vector2(0, 0)
var dashAmount = 1
var currentDashAmount = 0
var canDash = true
var dashing = false
var dashSpeed = 1250

var joy_jump_pressed = false

var currentweapon = 0
var shootCooldown = 0.15
var isHoldingGun = false
var attacking = false
var isHit = false
var onWall = false
var canShoot = true
var hasPistol = false
var totalBullets = 12
var bulletsLeft = 0
#var velocity = Vector2(0, 1)
var speed = 300
var knockback_strength = 150
var health = 100
var lives = 3
var isDead = false

var directionX
var directionY
var direction_inputX
var direction_inputY
var facingRight = true

var playerCharacter = 0

var africanPistolMarker = Vector2(14.429,-2.571)
var chinesePistolMarker = Vector2(11.571, -4)
var japanesePistolMarker = Vector2(14.429, -8.286)
var mexicanPistolMarker = Vector2(14.429, 0.286)
var vikingPistolMarker = Vector2(14.429, -1.143)
var polynesianPistolMarker = Vector2(14.429, -4)

var attackTime
var africanAttackTime = 0.09
var chineseAttackTime = 0.1
var japaneseAttackTime = 0.125
var mexicanAttackTime = 0.06
var samoanAttackTime = 0.1
var vikingAttackTime = 0.34
var meleeDamage
var africanMeleeDamage = 6
var chineseMeleeDamage = 7
var japaneseMeleeDamage = 6
var mexicanMeleeDamage = 5
var vikingMeleeDamage = 9
var samoanMeleeDamage = 6

@export var DEADZONE = 0.2
@export var DEADZONEY = 0.9
@export var gunDamage = 2
@export var rocketLauncherDamage = 10
@export var sniperDamage = 15
var player_controller_index
var playercontroller = true
@onready var _animated_sprite = $CollisionShape2D/AnimatedSprite2D
@onready var Gun = $CollisionShape2D/AnimatedSprite2D/Gun
@onready var africanAttackCollision = $CollisionShape2D/AnimatedSprite2D/Melee/AfricanAttackCollision
@onready var chineseAttackCollision = $CollisionShape2D/AnimatedSprite2D/Melee/ChineseAttackCollision
@onready var japaneseAttackCollision = $CollisionShape2D/AnimatedSprite2D/Melee/JapaneseAttackCollision
@onready var mexicanAttackCollision = $CollisionShape2D/AnimatedSprite2D/Melee/MexicanAttackCollision
@onready var samoanAttackCollision = $CollisionShape2D/AnimatedSprite2D/Melee/SamoanAttackCollision
@onready var vikingAttackCollision = $CollisionShape2D/AnimatedSprite2D/Melee/VikingAttackCollision
@onready var global_script = $"/root/Global"
@onready var gunSprite = $"CollisionShape2D/AnimatedSprite2D/Gun"
@onready var playerLabel = $"Label"
@onready var muzzleFlashPistol = $CollisionShape2D/AnimatedSprite2D/Gun/Marker2D/MuzzleFlashPistol
@onready var bulletMarker = $CollisionShape2D/AnimatedSprite2D/Gun/Marker2D
@onready var walkParticle = $CollisionShape2D/AnimatedSprite2D/WalkParticle
@onready var spawnlocation1 = $"../SpawnLocation1"
@onready var spawnlocation2 = $"../SpawnLocation2"
@onready var WinText = $"../TextureRect/Label"
@onready var fallParticle = $"../fallSplashParticle"
@onready var killParticle = $"../killParticle"
var _attack_collision
func _ready():
	shootCooldown = 0.2
	health = 100
	isDead = false
	if player_index == 1:
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
	
	if player_index == 1:
		playerCharacter = global_script.globalPlayerCharacter1
	elif player_index == 2:
		playerCharacter = global_script.globalPlayerCharacter2
	playerLabel.text = "Player: " + str(player_index)
	if playerCharacter == 1:
		gunSprite.texture = africanPistolSprite
		bulletMarker.position = africanPistolMarker
		_attack_collision = africanAttackCollision
		attackTime = africanAttackTime
		meleeDamage = africanMeleeDamage
	elif playerCharacter == 2:
		gunSprite.texture = chinesePistolSprite
		bulletMarker.position = chinesePistolMarker
		_attack_collision = chineseAttackCollision
		attackTime = chineseAttackTime
		meleeDamage = chineseMeleeDamage
	elif playerCharacter == 3:
		gunSprite.texture = japanesePistolSprite
		bulletMarker.position = japanesePistolMarker
		_attack_collision = japaneseAttackCollision
		attackTime = japaneseAttackTime
		meleeDamage = japaneseMeleeDamage
	elif playerCharacter == 4:
		gunSprite.texture = polynesianPistolSprite
		bulletMarker.position = polynesianPistolMarker
		_attack_collision = samoanAttackCollision
		attackTime = samoanAttackTime
		meleeDamage = samoanMeleeDamage
	elif playerCharacter == 5:
		gunSprite.texture = norwegianPistolSprite
		bulletMarker.position = vikingPistolMarker
		_attack_collision = vikingAttackCollision
		attackTime = vikingAttackTime
		meleeDamage = vikingMeleeDamage
	elif playerCharacter == 6:
		gunSprite.texture = mexicanPistolSprite
		bulletMarker.position = mexicanPistolMarker
		_attack_collision = mexicanAttackCollision
		attackTime = mexicanAttackTime
		meleeDamage = mexicanMeleeDamage
	_attack_collision.disabled = true
	hasPistol = false
func _physics_process(_delta):
	if player_index == 1:
		global_script.player1health = health
		global_script.globalPlayer1Lives = lives
	elif player_index == 2:
		global_script.player2health = health
		global_script.globalPlayer2Lives = lives
	if global_script.isPaused == false && isDead == false:
		if hasPistol:
			isHoldingGun = true
		else:
			isHoldingGun = false
		if health <= 0:
			die()
			killed()
		if playercontroller:
			if isHoldingGun:
				if Input.is_joy_button_pressed(player_controller_index, 2):
					shoot()
			else:
				if Input.is_joy_button_pressed(player_controller_index, 2):
					attack()
		else:
			isHoldingGun = false
		if health <= 0:
			die()
			killed()
		if playercontroller:
			if isHoldingGun:
				if Input.is_joy_button_pressed(player_controller_index, 2):
					shoot()
			else:
				if Input.is_joy_button_pressed(player_controller_index, 2):
					attack()
		else:
			if isHoldingGun:
				if Input.is_joy_button_pressed(player_controller_index, 2):
					shoot()
			else:
				if Input.is_joy_button_pressed(player_controller_index, 2):
					attack()
		else:
			isHoldingGun = true
	if knockback_health < 0:
		knockback_health = 0
	if player_index == 0:
		global_script.player1health = knockback_health
	elif player_index == 1:
		global_script.player2health = knockback_health
		
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
		if velocity.x != 0 && is_on_floor():
			walkParticle.emitting = true
		else:
			walkParticle.emitting = false
		if hasPistol:
			Gun.modulate = Color(1, 1, 1, 1)
			if onWall:
				Gun.visible = false
			else:
				Gun.visible = true
		else:
				if player_keyboard_index == 0:
					if Input.is_action_just_pressed("shoot") && !onWall:
						attack()
				elif player_keyboard_index == 1:
					if Input.is_action_just_pressed("shoot2") && !onWall:
						attack()
		if playerCharacter == 1: # African
			if velocity == Vector2(0, 0) && !attacking:
				_animated_sprite.play("africanidle")
			if is_on_floor() && !dashing && !attacking:
				if velocity.x > 0:
					_animated_sprite.play("africanwalk")
				elif velocity.x < 0:
					_animated_sprite.play("africanwalk")
			if !is_on_floor() && !attacking:
				_animated_sprite.play("africanjump")
			if is_on_wall() && !is_on_floor() && !attacking:
				_animated_sprite.play("africanwall")
				
		if playerCharacter == 2: # Chinese
			if velocity == Vector2(0, 0) && !attacking:
				_animated_sprite.play("chinaidle")
			if is_on_floor() && !dashing && !attacking:
				if velocity.x > 0:
					_animated_sprite.play("chinawalk")
				elif velocity.x < 0:
					_animated_sprite.play("chinawalk")
			if !is_on_floor() && !attacking:
				_animated_sprite.play("chinajump")
			if is_on_wall() && !is_on_floor() && !attacking:
				_animated_sprite.play("chinawall")
				
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
				
		if playerCharacter == 4: # Samoan
			if velocity == Vector2(0, 0) && !attacking:
				_animated_sprite.play("samoanidle")
			if is_on_floor() && !dashing && !attacking:
				if velocity.x > 0:
					_animated_sprite.play("samoanwalk")
				elif velocity.x < 0:
					_animated_sprite.play("samoanwalk")
			if !is_on_floor() && !attacking:
				_animated_sprite.play("samoanjump")
			if is_on_wall() && !is_on_floor() && !attacking:
				_animated_sprite.play("samoanwall")
		
		if playerCharacter == 5: # Viking
			if velocity == Vector2(0, 0) && !attacking:
				_animated_sprite.play("vikingidle")
			if is_on_floor() && !dashing && !attacking:
				if velocity.x > 0:
					_animated_sprite.play("vikingwalk")
				elif velocity.x < 0:
					_animated_sprite.play("vikingwalk")
			if !is_on_floor() && !attacking:
				_animated_sprite.play("vikingjump")
			if is_on_wall() && !is_on_floor() && !attacking:
				_animated_sprite.play("vikingwall")
		
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
		if velocity.x != 0 && is_on_floor():
			walkParticle.emitting = true
		else:
			walkParticle.emitting = false
		if hasPistol:
			Gun.modulate = Color(1, 1, 1, 1)
			if onWall:
				Gun.visible = false
			else:
				Gun.visible = true
		else:
			Gun.visible = false
			Gun.modulate = Color(1, 1, 1, 0)
		if is_on_wall() && !is_on_floor() && !attacking:
			onWall = true
		else:
			onWall = false
		if facingRight && !attacking:
			_animated_sprite.scale.x = 1
		elif !facingRight && !attacking:
			_animated_sprite.scale.x = -1
		#if velocity.x > 0:
			#_animated_sprite.scale.x = 1
			#facingRight = true
		#elif velocity.x < 0:
			#_animated_sprite.scale.x = -1
			#facingRight = false

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
			directionX = (direction_inputX - sign(direction_inputX) * DEADZONE) / (1 - DEADZONE)
			directionX = sign(directionX)
			if directionX > 0:
				facingRight = true
			elif directionX < 0:
				facingRight = false
		if dashing && !isHit:
				velocity.x = dashSpeed * dashDirection
		elif !isHit && directionX != 0 && !dashing && !attacking:
			velocity.x = velocity.x + (ACCELERATION * directionX)
				
		if velocity.x > MAX_SPEED:
			velocity.x = move_toward(velocity.x, 0, MAX_FRICTION)
		elif velocity.x < -MAX_SPEED:
			velocity.x = move_toward(velocity.x, 0, MAX_FRICTION)
		else:
			crouching = false
	else:
		if Input.is_action_pressed("move_down"):
			crouching = true
			if is_on_floor():
				position.y += 1
			if player_keyboard_index == 0:
				direction_inputX = Input.get_axis("move_left", "move_right")
			elif player_keyboard_index == 1:
				direction_inputX = Input.get_axis("move_left2", "move_right2")
		# Adds Deadzone
		if abs(direction_inputX) < DEADZONE:
			directionX = 0
		else:
			directionX = (direction_inputX - sign(direction_inputX) * DEADZONE) / (1 - DEADZONE)
			directionX = sign(directionX)
			if directionX > 0:
				facingRight = true
			elif directionX < 0:
				facingRight = false
		if dashing && !isHit:
				velocity.x = dashSpeed * dashDirection
		elif !isHit && directionX != 0 && !dashing && !attacking:
			velocity.x = velocity.x + (ACCELERATION * directionX)
				
		if velocity.x > MAX_SPEED:
			velocity.x = move_toward(velocity.x, 0, MAX_FRICTION)
		elif velocity.x < -MAX_SPEED:
			velocity.x = move_toward(velocity.x, 0, MAX_FRICTION)

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
			if player_keyboard_index == 0:
				if Input.is_action_pressed("move_down"):
					if is_on_floor():
						position.y += 1
			if player_keyboard_index == 1:
				if Input.is_action_pressed("move_down2"):
					if is_on_floor():
						position.y += 1

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
			joy_jump_pressed = false
	
	if is_on_wall() && (directionX == -1 || directionX == 1) && !attacking:
		dub_jumps = max_num_dub_jumps
		if velocity.y >= 0: 
			velocity.y = min(velocity.y + WALL_SLIDE_ACCELERATION, MAX_WALL_SLIDE_SPEED)
		else:
			if player_keyboard_index == 0:
				if !doubleKeyboard:
					if Input.is_action_just_pressed("jump") && !attacking:
						if !joy_jump_pressed:
							joy_jump_pressed = true
							if dub_jumps > 0: 
								dub_jumps -= 1
								velocity.y = -JUMP_HIGHT
							if is_on_wall() && directionX == 1:
								velocity.x = -(MAX_SPEED * 2)
							elif is_on_wall() && directionX == -1:
								velocity.x = (MAX_SPEED * 2)
					else:
						joy_jump_pressed = false
				elif doubleKeyboard:
					if Input.is_action_just_pressed("move_up") && !attacking:
						if !joy_jump_pressed:
							joy_jump_pressed = true
							if dub_jumps > 0: 
								dub_jumps -= 1
								velocity.y = -JUMP_HIGHT
							if is_on_wall() && directionX == 1:
								velocity.x = -(MAX_SPEED * 2)
							elif is_on_wall() && directionX == -1:
								velocity.x = (MAX_SPEED * 2)
					else:
						joy_jump_pressed = false
			elif player_keyboard_index == 1:
				if Input.is_action_just_pressed("move_up2") && !attacking:
					if !joy_jump_pressed:
						joy_jump_pressed = true
						if dub_jumps > 0: 
							dub_jumps -= 1
							velocity.y = -JUMP_HIGHT
						if is_on_wall() && directionX == 1:
							velocity.x = -(MAX_SPEED * 2)
						elif is_on_wall() && directionX == -1:
							velocity.x = (MAX_SPEED * 2)
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
	if canShoot && bulletsLeft > 0 && isHoldingGun:
		bulletsLeft -= 1
		if bulletsLeft <= 0:
			hasPistol = false
		muzzleFlashPistol.emitting = true
		var bullet = bulletPath.instantiate()
		if facingRight:
			bullet.bulletspawn(1, player_index, gunDamage)
		else:
			bullet.bulletspawn(-1, player_index, gunDamage)
		bullet.global_position = $CollisionShape2D/AnimatedSprite2D/Gun/Marker2D.global_position
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
		time_to_attack()
		attacking = true
		if playerCharacter == 1:
			_animated_sprite.play("africanattack")
		if playerCharacter == 2:
			_animated_sprite.play("chinaattack")
		if playerCharacter == 3:
			_animated_sprite.play("japaneseattack")
		if playerCharacter == 4:
			_animated_sprite.play("samoanattack")
		if playerCharacter == 5:
			_animated_sprite.play("vikingattack")
		if playerCharacter == 6:
			_animated_sprite.play("mexicanattack")
	
func time_to_attack():
	await get_tree().create_timer(attackTime).timeout
	_attack_collision.disabled = false

func _on_melee_body_entered(body):
	if body.is_in_group("player"):
		body.is_hit(global_position, meleeDamage)

func is_hit(attacker_position, damage_done):
	if !isDead && !isHit:
		var knockback_direction = global_position - attacker_position
		health = health - damage_done
		if knockback_direction.x > 0:
			velocity.x = velocity.x + (knockback_strength * damage_done + 25 * ((100 - health) + 1))
		elif knockback_direction.x < 0:
			velocity.x = velocity.x - (knockback_strength * damage_done + 25 * ((100 - health) + 1))
		isHit = true
		_animated_sprite.modulate = Color(1, 0, 0) 
		await get_tree().create_timer(0.15).timeout
		isHit = false
		_animated_sprite.modulate = Color(1, 1, 1)
	

func _on_animated_sprite_2d_animation_finished():
	if (_animated_sprite.animation == "africanattack" or _animated_sprite.animation == "chinaattack" or _animated_sprite.animation == "japaneseattack" or _animated_sprite.animation == "samoanattack" or _animated_sprite.animation == "vikingattack" or _animated_sprite.animation == "mexicanattack"):
		gunSprite.show()
		_attack_collision.disabled = true
		attacking = false


func _on_area_2d_area_entered(area):
	if area.is_in_group("boundary"):
		fallParticle.global_position.x = global_position.x
		fallParticle.emitting = true
		die()
		
func get_player_index():
	return(player_index)

func bullet_hit(bullet_direction, damage_done):
	if !isDead && !isHit:
		var knockback_direction = bullet_direction
		health = health - damage_done
		if knockback_direction > 0:
			velocity.x = velocity.x + (knockback_strength * damage_done + 30 * ((100 - health) + 1))
		elif knockback_direction < 0:
			velocity.x = velocity.x - (knockback_strength * damage_done + 30 * ((100 - health) + 1))
		isHit = true
		_animated_sprite.modulate = Color(1, 0, 0) 
		await get_tree().create_timer(0.15).timeout
		isHit = false
		_animated_sprite.modulate = Color(1, 1, 1)

func die():
	isDead = true
	self.visible = false
	health = 100
	lives -= 1
	if lives > 0:
		if player_index == 1:
			global_position = spawnlocation1.global_position
			velocity = Vector2(0, 0)
		elif player_index == 2:
			global_position = spawnlocation2.global_position
			velocity = Vector2(0, 0)
		await get_tree().create_timer(1).timeout
		isDead = false
		self.visible = true
	if lives <= 0:
		if player_index == 1:
			global_script.winningPlayer = 2
		elif player_index == 2:
			global_script.winningPlayer = 1
		WinText.text = "Player " + str(player_index) + " Wins!"
		WinText.visible = true
		await get_tree().create_timer(0.1).timeout
		global_script.isPaused = true
		await get_tree().create_timer(1.5).timeout
		global_script.isPaused = false
		get_tree().change_scene_to_file("res://scenes/win.tscn")

func killed():
	killParticle.global_position = global_position
	killParticle.emitting = true

func collect_item(itemType):
	global_script.crateNumber -= 1
	if itemType == 1:
		hasPistol = true
		bulletsLeft = totalBullets
