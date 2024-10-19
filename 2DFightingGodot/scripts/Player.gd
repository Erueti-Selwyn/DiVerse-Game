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
var joy_shoot_pressed = false

var currentweapon = 0
var shootCooldown
var pistolCooldown = 0.15
var sniperCooldown = 0.7
var attacking = false
var isHit = false
var onWall = false
var canShoot = true
var hasGun = false
var gunType
var totalBullets = 12
var totalSniperBullets = 5
var bulletsLeft = 0
#var velocity = Vector2(0, 1)
var speed = 300
var melee_knockback_strength = 75
var gun_knockback_strength = 150
var sniper_knockback_strength = 50
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
var sniperMarker = Vector2(27.286, -2.571)

var attackTime
var africanAttackTime = 0.09
var chineseAttackTime = 0.1
var japaneseAttackTime = 0.125
var mexicanAttackTime = 0
var samoanAttackTime = 0.1
var vikingAttackTime = 0.34
var meleeDamage
var africanMeleeDamage = 12
var chineseMeleeDamage = 14
var japaneseMeleeDamage = 12
var mexicanMeleeDamage = 10
var vikingMeleeDamage = 18
var samoanMeleeDamage = 12
var meleeHasHit = false
@export var DEADZONE = 0.2
@export var DEADZONEY = 0.9
@export var gunDamage = 6
@export var rocketLauncherDamage = 50
@export var sniperDamage = 30
var player_controller_index
var player_keyboard_index
var playercontroller = true
var doubleKeyboard
var normalPistolTexture
var normalPistolMarker
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
@onready var muzzleFlash = $CollisionShape2D/AnimatedSprite2D/Gun/Marker2D/MuzzleFlashPistol
@onready var bulletMarker = $CollisionShape2D/AnimatedSprite2D/Gun/Marker2D
@onready var walkParticle = $CollisionShape2D/AnimatedSprite2D/WalkParticle
@onready var spawnlocation1
@onready var spawnlocation2
@onready var spawnLocationAfrica1 = $"../SpawnLocationAfrica1"
@onready var spawnLocationAfrica2 = $"../SpawnLocationAfrica2"
@onready var spawnLocationChina1 = $"../SpawnLocationChina1"
@onready var spawnLocationChina2 = $"../SpawnLocationChina2"
@onready var spawnLocationJapan1 = $"../SpawnLocationJapan1"
@onready var spawnLocationJapan2 = $"../SpawnLocationJapan2"
@onready var spawnLocationSamoa1 = $"../SpawnLocationSamoa1"
@onready var spawnLocationSamoa2 = $"../SpawnLocationSamoa2"
@onready var spawnLocationMexico1 = $"../SpawnLocationMexico1"
@onready var spawnLocationMexico2 = $"../SpawnLocationMexico2"
@onready var spawnLocationViking1 = $"../SpawnLocationViking1"
@onready var spawnLocationViking2 = $"../SpawnLocationViking2"
@onready var WinText = $"../WinText"
@onready var fallParticle = $"../fallSplashParticle"
@onready var killParticle = $"../killParticle"
@onready var damageNumberOrigin = $CollisionShape2D/AnimatedSprite2D/DamageNumberOrigin
var _attack_collision
func _ready():
	shootCooldown = pistolCooldown
	health = 100
	isDead = false
	hasGun = false
	# Sets Spawn Location for Player 1
	if player_index == 1:
		if global_script.mapType == 1:
			spawnlocation1 = spawnLocationAfrica1
		if global_script.mapType == 2:
			spawnlocation1 = spawnLocationChina1
		if global_script.mapType == 3:
			spawnlocation1 = spawnLocationJapan1
		if global_script.mapType == 4:
			spawnlocation1 = spawnLocationSamoa1
		if global_script.mapType == 5:
			spawnlocation1 = spawnLocationViking1
		if global_script.mapType == 6:
			spawnlocation1 = spawnLocationMexico1
		global_position = spawnlocation1.global_position
	# Sets Spawn Location for Player 2
	elif player_index == 2:
		if global_script.mapType == 1:
			spawnlocation2 = spawnLocationAfrica2
		if global_script.mapType == 2:
			spawnlocation2 = spawnLocationChina2
		if global_script.mapType == 3:
			spawnlocation2 = spawnLocationJapan2
		if global_script.mapType == 4:
			spawnlocation2 = spawnLocationSamoa2
		if global_script.mapType == 5:
			spawnlocation2 = spawnLocationViking2
		if global_script.mapType == 6:
			spawnlocation2 = spawnLocationMexico2
		global_position = spawnlocation2.global_position
	# Assigning Player Controller / Keyboard Inputs
	if player_index == 1:
		if global_script.player1Controller == true:
			player_controller_index = 0
			playercontroller = true
		elif global_script.player1Controller == false:
			playercontroller = false
			player_keyboard_index = 0
		if global_script.player1Controller == false && global_script.player2Controller == false:
			doubleKeyboard = true
	if player_index == 2:
		if global_script.player1Controller == false && global_script.player2Controller == true:
			player_controller_index = 0
		elif global_script.player1Controller == true && global_script.player2Controller == false:
			player_keyboard_index = 0
		elif global_script.player1Controller == true && global_script.player2Controller == true:
			player_controller_index = 1
		elif global_script.player1Controller == false && global_script.player2Controller == false:
			player_keyboard_index = 1
		if global_script.player2Controller == true:
			playercontroller = true
		elif global_script.player2Controller == false:
			playercontroller = false
	# Sets the Players to chosen Characters
	if player_index == 1:
		playerCharacter = global_script.globalPlayerCharacter1
	elif player_index == 2:
		playerCharacter = global_script.globalPlayerCharacter2
	playerLabel.text = "Player: " + str(player_index)
	# Sets Different Variables for each character
	if playerCharacter == 1:
		gunSprite.texture = africanPistolSprite
		normalPistolTexture = africanPistolSprite
		normalPistolMarker = africanPistolMarker
		bulletMarker.position = africanPistolMarker
		_attack_collision = africanAttackCollision
		attackTime = africanAttackTime
		meleeDamage = africanMeleeDamage
	elif playerCharacter == 2:
		gunSprite.texture = chinesePistolSprite
		normalPistolTexture = chinesePistolSprite
		normalPistolMarker = chinesePistolMarker
		bulletMarker.position = chinesePistolMarker
		_attack_collision = chineseAttackCollision
		attackTime = chineseAttackTime
		meleeDamage = chineseMeleeDamage
	elif playerCharacter == 3:
		gunSprite.texture = japanesePistolSprite
		normalPistolTexture = japanesePistolSprite
		normalPistolMarker = japanesePistolMarker
		bulletMarker.position = japanesePistolMarker
		_attack_collision = japaneseAttackCollision
		attackTime = japaneseAttackTime
		meleeDamage = japaneseMeleeDamage
	elif playerCharacter == 4:
		gunSprite.texture = polynesianPistolSprite
		normalPistolTexture = polynesianPistolSprite
		normalPistolMarker = polynesianPistolMarker
		bulletMarker.position = polynesianPistolMarker
		_attack_collision = samoanAttackCollision
		attackTime = samoanAttackTime
		meleeDamage = samoanMeleeDamage
	elif playerCharacter == 5:
		gunSprite.texture = norwegianPistolSprite
		normalPistolTexture = norwegianPistolSprite
		normalPistolMarker = vikingPistolMarker
		bulletMarker.position = vikingPistolMarker
		_attack_collision = vikingAttackCollision
		attackTime = vikingAttackTime
		meleeDamage = vikingMeleeDamage
	elif playerCharacter == 6:
		gunSprite.texture = mexicanPistolSprite
		normalPistolTexture = mexicanPistolSprite
		normalPistolMarker = mexicanPistolMarker
		bulletMarker.position = mexicanPistolMarker
		_attack_collision = mexicanAttackCollision
		attackTime = mexicanAttackTime
		meleeDamage = mexicanMeleeDamage
	_attack_collision.disabled = true
func _physics_process(_delta):
	# Assigns Global Script Variables
	if player_index == 1:
		global_script.player1health = health
		global_script.globalPlayer1Lives = lives
	elif player_index == 2:
		global_script.player2health = health
		global_script.globalPlayer2Lives = lives
	# Pauses all Movement when Paused / Dead
	if global_script.isPaused == false && isDead == false:
		# Applies Character Animation
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
		# Checking if is Controller and Shoot
		if playercontroller:
			if hasGun:
				if Input.is_joy_button_pressed(player_controller_index, 2) && !onWall:
					if !joy_shoot_pressed:
						joy_shoot_pressed = true
						shoot()
				else:
					joy_shoot_pressed = false
			else:
				if Input.is_joy_button_pressed(player_controller_index, 2) && !onWall:
					if !joy_shoot_pressed:
						joy_shoot_pressed = true
						attack()
				else:
					joy_shoot_pressed = false
		else:
			if hasGun:
				# Changes Keyboard Input Depending on Keyboard Index
				if player_keyboard_index == 0:
					if Input.is_action_just_pressed("shoot") && !onWall:
							shoot()
				elif player_keyboard_index == 1:
					if Input.is_action_just_pressed("shoot2") && !onWall:
						shoot()
			else:
				# Changes Keyboard Input Depending on Keyboard Index
				if player_keyboard_index == 0:
					if Input.is_action_just_pressed("shoot") && !onWall:
						attack()
				elif player_keyboard_index == 1:
					if Input.is_action_just_pressed("shoot2") && !onWall:
						attack()
		# Adds Walking Particle
		if velocity.x != 0 && is_on_floor():
			walkParticle.emitting = true
		else:
			walkParticle.emitting = false
		# Shows / Hides Gun based on Variables
		if hasGun:
			if (onWall || attacking):
				Gun.visible = false
			else:
				Gun.visible = true
		else:
			Gun.visible = false
		# Sets On Wall Variable
		if is_on_wall() && !is_on_floor() && !attacking:
			onWall = true
		else:
			onWall = false
		if facingRight && !attacking:
			_animated_sprite.scale.x = 1
		elif !facingRight && !attacking:
			_animated_sprite.scale.x = -1

		# Detects Dash Input
		if playercontroller:
			if Input.is_joy_button_pressed(player_controller_index, 1):
				dash()
		else:
			if player_keyboard_index == 0:
				if Input.is_action_just_pressed("dash"):
					dash()
			elif player_keyboard_index == 1:
				if Input.is_action_just_pressed("dash2"):
					dash()
		# Gets Controller Joystick Input or Keyboard Input
		if playercontroller:
			direction_inputX = Input.get_joy_axis(player_controller_index, 0)
		else:
			# Changes Input based on Keyboard Index
			if player_keyboard_index == 0:
				direction_inputX = Input.get_axis("move_left", "move_right")
			elif player_keyboard_index == 1:
				direction_inputX = Input.get_axis("move_left2", "move_right2")
		# Adds Deadzone for Controller Joystick Input
		if abs(direction_inputX) < DEADZONE:
			directionX = 0
		else:
			directionX = (direction_inputX - sign(direction_inputX) * DEADZONE) / (1 - DEADZONE)
			directionX = sign(directionX)
			# Changes Facing Direction based on Movement Input
			if directionX > 0:
				facingRight = true
			elif directionX < 0:
				facingRight = false
		# Adds Dashing Velocity when Dashing
		if dashing && !isHit:
				velocity.x = dashSpeed * dashDirection
		# Adds Movement and Acceleration
		elif !isHit && directionX != 0 && !dashing && !attacking:
			velocity.x = velocity.x + (ACCELERATION * directionX)
		# Limits Max Speed
		if velocity.x > MAX_SPEED:
			velocity.x = move_toward(velocity.x, 0, MAX_FRICTION)
		elif velocity.x < -MAX_SPEED:
			velocity.x = move_toward(velocity.x, 0, MAX_FRICTION)
		else:
			velocity.x = move_toward(velocity.x, 0, FRICTION)
		# Detects if Player is Holding Down, to Move through One Way Platforms
		if playercontroller:
			direction_inputY = Input.get_joy_axis(player_controller_index, 1)
			if abs(direction_inputY) < DEADZONEY:
				directionY = 0
			else:
				directionY = (direction_inputY - sign(direction_inputY) * DEADZONEY) / (1 - DEADZONEY)
			if directionY > 0:
				if is_on_floor():
					position.y += 1
		else:
			if player_keyboard_index == 0:
				if Input.is_action_pressed("move_down"):
					if is_on_floor():
						position.y += 1
			if player_keyboard_index == 1:
				if Input.is_action_pressed("move_down2"):
					if is_on_floor():
						position.y += 1
		# Reset Jumps and Velocity
		if is_on_floor(): 
			dub_jumps = max_num_dub_jumps
			velocity.y = 0
		if playercontroller:
			# Adds Jump button for Controller
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
			# Player 1 Keyboard Jump Input
			if player_keyboard_index == 0:
				if !doubleKeyboard:
					# Adds Jump Button for Single Keyboard
					if (Input.is_action_just_pressed("jump") || Input.is_action_just_pressed("move_up")) && !attacking:
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
					# Adds Jump Button for Double Keyboard
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
				# Player 1 Keyboard Jump Input
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
		# Wall Climbing
		if is_on_wall() && (directionX == -1 || directionX == 1) && !attacking:
			dub_jumps = max_num_dub_jumps
			if velocity.y >= 0: 
				velocity.y = min(velocity.y + WALL_SLIDE_ACCELERATION, MAX_WALL_SLIDE_SPEED)
			else:
				velocity.y += GRAVITY
		# Adds Gravity
		elif !is_on_floor():
			velocity.y += GRAVITY
		# Removes Y Velocity When Dashing
		if dashing:
			velocity.y = 0
		# Sets Dash when on Ground or Wall
		if (is_on_floor() || onWall):
			currentDashAmount = dashAmount
		
		move_and_slide()
	
	
func shoot(): 
	if canShoot && bulletsLeft > 0 && hasGun && !attacking:
		bulletsLeft -= 1
		if bulletsLeft <= 0:
			# Removes Gun
			hasGun = false
		# Muzzle Flash
		muzzleFlash.emitting = true
		# Instantiate's Bullet
		var bullet = bulletPath.instantiate()
		# Changes Bullet Variable Based on Gun Type
		if gunType == 1:
			if facingRight:
				bullet.bulletspawn(1, player_index, gunDamage, gunType)
			else:
				bullet.bulletspawn(-1, player_index, gunDamage, gunType)
		if gunType == 2:
			if facingRight:
				bullet.bulletspawn(1, player_index, sniperDamage, gunType)
			else:
				bullet.bulletspawn(-1, player_index, sniperDamage, gunType)
		# Moves Bullet to Marker
		bullet.global_position = bulletMarker.global_position
		# Adds Bullet to Parent
		get_parent().add_child(bullet)
		# Adds Shot Delay
		if hasGun:
			canShoot = false
			await get_tree().create_timer(shootCooldown).timeout
			canShoot = true

func dash():
	# Checks if can Dash
	if !attacking && !isHit:
		if !dashing:
			# Sets Dash Direction
			if facingRight:
				dashDirection = 1
			else:
				dashDirection = -1
		# Checks if Dash is Avalible
		if currentDashAmount > 0 and !dashing and canDash:
			dashing = true
			canDash = false
			currentDashAmount -= 1
			# Dash Time
			await get_tree().create_timer(0.1).timeout
			dashing = false
			# Dash Cooldown
			await get_tree().create_timer(0.5).timeout
			canDash = true
			
func attack():
	# Checks if Can Attack
	if !attacking && !dashing:
		# Attack Delay
		time_to_attack()
		attacking = true
		# Attack Animation
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
	# Time for Attack to Activate
	await get_tree().create_timer(attackTime).timeout
	_attack_collision.disabled = false

func _on_melee_body_entered(body):
	# Melee Hit Detection
	if body.is_in_group("player") && !meleeHasHit:
		# Sends Attacker Location and Melee Damage
		body.is_hit(facingRight, meleeDamage)
		meleeHasHit = true
		

func is_hit(attackerFacingRight, damage_done):
	# Checks if Can be Hit
	if !isDead && !isHit:
		# Creates Damage Number
		global_script.display_damage_number(damage_done, damageNumberOrigin.global_position)
		# Health takes Damage
		health = health - damage_done
		# Checks if Health is 0
		if health <= 0:
			# Emmits Death Particles
			killParticle.global_position = global_position
			killParticle.emitting = true
			die()
		else:
			# Adds Knockback Based on Attacker Direction
			if attackerFacingRight:
				velocity.x = velocity.x + (melee_knockback_strength * damage_done + 20 * pow((100 - health), 1.1))
			elif !attackerFacingRight:
				velocity.x = velocity.x - (melee_knockback_strength * damage_done + 20 * pow((100 - health), 1.1))
			isHit = true
			_animated_sprite.modulate = Color(1, 0, 0) 
			# Creates Hit Timer
			await get_tree().create_timer(0.15).timeout
			isHit = false
			_animated_sprite.modulate = Color(1, 1, 1)
	

func _on_animated_sprite_2d_animation_finished():
	if (_animated_sprite.animation == "africanattack" or _animated_sprite.animation == "chinaattack" or _animated_sprite.animation == "japaneseattack" or _animated_sprite.animation == "samoanattack" or _animated_sprite.animation == "vikingattack" or _animated_sprite.animation == "mexicanattack"):
		# Starts when Attack Finishes
		meleeHasHit = false
		_attack_collision.disabled = true
		attacking = false


func _on_area_2d_area_entered(area):
	# Checks if Hit Boundary
	if area.is_in_group("boundary"):
		# Summons Fall Particles
		fallParticle.global_position.x = global_position.x
		fallParticle.emitting = true
		die()
		
func get_player_index():
	# Returns Player Index
	return(player_index)

func bullet_hit(bullet_direction, damage_done, hitGunType):
	# When Hit by Bullet
	if !isDead && !isHit:
		# Sets Knockback Direction
		var knockback_direction = bullet_direction
		# Creates Damage Number
		global_script.display_damage_number(damage_done, damageNumberOrigin.global_position)
		# Health takes Damage
		health = health - damage_done
		# Checks if Dead
		if health <= 0:
			killParticle.global_position = global_position
			killParticle.emitting = true
			die()
		else:
			# Adds Knockback for Pistol
			if hitGunType == 1:
				if knockback_direction > 0:
					velocity.x = velocity.x + (gun_knockback_strength * damage_done + 20 * pow((100 - health), 1.1))
				elif knockback_direction < 0:
					velocity.x = velocity.x - (gun_knockback_strength * damage_done + 20 * pow((100 - health), 1.1))
			# Adds Knockback for Sniper
			if hitGunType == 2:
				if knockback_direction > 0:
					velocity.x = velocity.x + (sniper_knockback_strength * damage_done + 20 * pow((100 - health), 1.1))
				elif knockback_direction < 0:
					velocity.x = velocity.x - (sniper_knockback_strength * damage_done + 20 * pow((100 - health), 1.1))
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
		velocity = Vector2(0, 0)
	if lives <= 0:
		if player_index == 1:
			global_script.winningPlayer = 2
		elif player_index == 2:
			global_script.winningPlayer = 1
		WinText.text = "Player " + str(global_script.winningPlayer) + " Wins!"
		WinText.visible = true
		await get_tree().create_timer(0.1).timeout
		global_script.isPaused = true
		await get_tree().create_timer(1.5).timeout
		global_script.isPaused = false
		get_tree().change_scene_to_file("res://scenes/win.tscn")

func collect_item(itemType):
	global_script.crateNumber -= 1
	gunType = itemType
	if itemType == 1:
		hasGun = true
		canShoot = true
		gunSprite.texture = normalPistolTexture
		bulletMarker.position = normalPistolMarker
		shootCooldown = pistolCooldown
		bulletsLeft = totalBullets
	elif itemType == 2:
		hasGun = true
		canShoot = true
		gunSprite.texture = sniperSprite
		bulletMarker.position = sniperMarker
		shootCooldown = sniperCooldown
		bulletsLeft = totalSniperBullets
