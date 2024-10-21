extends CharacterBody2D

@export var playerIndex = 1
# Assets
const africanPistolSprite = preload("res://assets/guns/africanpistol.png")
const chinesePistolSprite = preload("res://assets/guns/chinesepistol.png")
const japanesePistolSprite = preload("res://assets/guns/japanesepistol.png")
const mexicanPistolSprite = preload("res://assets/guns/mexicanpistol.png")
const vikingPistolSprite = preload("res://assets/guns/norwegianpistol.png")
const samoanPistolSprite = preload("res://assets/guns/polynesianpistol.png")
const rocketLauncherSprite = preload("res://assets/guns/rocketlauncher.png")
const sniperSprite = preload("res://assets/guns/sniper.png")
const bulletPath = preload("res://scenes/bullet.tscn")

# Nodes
@onready var global_script = $"/root/Global"
@onready var _animated_sprite = $CollisionShape2D/AnimatedSprite2D
@onready var Gun = $CollisionShape2D/AnimatedSprite2D/Gun
@onready var africanAttackCollision = $CollisionShape2D/AnimatedSprite2D/Melee/AfricanAttackCollision
@onready var chineseAttackCollision = $CollisionShape2D/AnimatedSprite2D/Melee/ChineseAttackCollision
@onready var japaneseAttackCollision = $CollisionShape2D/AnimatedSprite2D/Melee/JapaneseAttackCollision
@onready var mexicanAttackCollision = $CollisionShape2D/AnimatedSprite2D/Melee/MexicanAttackCollision
@onready var samoanAttackCollision = $CollisionShape2D/AnimatedSprite2D/Melee/SamoanAttackCollision
@onready var vikingAttackCollision = $CollisionShape2D/AnimatedSprite2D/Melee/VikingAttackCollision
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
@onready var dashAudioPlayer = $"DashAudioPlayer"
@onready var deathAudioPlayer = $"DeathAudioPlayer"
@onready var hitMarkerAudioPlayer = $"HitMarkerAudioPlayer"
@onready var jumpAudioPlayer = $"JumpAudioPlayer"
@onready var landingAudioPlayer = $LandingAudioPlayer
@onready var pistolBulletAudioPlayer = $"PistolBulletAudioPlayer"
@onready var sniperBulletAudioPlayer = $"SniperBulletAudioPlayer"
@onready var walkingAudioPlayer = $"WalkingAudioPlayer"
@onready var weaponPickupAudioPlayer = $"WeaponPickupAudioPlayer"
@onready var weaponSwingAudioPlayer = $"WeaponSwingAudioPlayer"

# Movement Variables
const maxSpeed : int= 450
const acceleration : int = 120
const attackingAcceleration : int = 60
const maxFriction : int = 225
const friction : int = 30
const jumpHeight : int = 600
const gravity : int = 30
const maxGravity : int = 1000
const maxDoubleJumps : int = 3 
const wallSlideAcceleration : int = 10
const maxWallSlideSpeed : int = 40
var onWall : bool = false
var doubleJumps : int = 0
var dashDirection : float = 0
var dashAmount : int = 1
var currentDashAmount : int = 0
var canDash : bool= true
var dashing : bool= false
var dashSpeed : int = 1250
var wasFalling : bool = false
# Input Variables
var joyJumpPressed : bool = false
var joyShootPressed : bool = false
var directionX : float
var directionY : float
var directionInputX : float
var directionInputY : float
const deadzone : float = 0.2
const deadzoneY : float = 0.9
var facingRight : bool = true
# Gun Variables
var shootCooldown : float
const pistolCooldown : float = 0.15
const sniperCooldown : float = 0.7
var canShoot : bool = true
var hasGun : bool = false
var gunType : int
const totalBullets : int = 12
const totalSniperBullets : int = 5
var bulletsLeft : int = 0
const gunDamage : int = 6
const rocketLauncherDamage : int = 50
const sniperDamage : int = 30
const africanPistolMarker = Vector2(14.429,-2.571)
const chinesePistolMarker = Vector2(11.571, -4)
const japanesePistolMarker = Vector2(14.429, -8.286)
const mexicanPistolMarker = Vector2(14.429, 0.286)
const vikingPistolMarker = Vector2(14.429, -1.143)
const samoanPistolMarker = Vector2(14.429, -4)
const sniperMarker = Vector2(27.286, -2.571)
var normalPistolTexture
var normalPistolMarker

# Attacking Variables
const meleeKnockbackStrength : int = 75
const gunKnockbackStrength : int = 150
const sniperKnockbackStrength : int= 50
var attackTime : float
const africanAttackTime : float = 0.09
const chineseAttackTime : float = 0.1
const japaneseAttackTime : float = 0.125
const mexicanAttackTime : float = 0
const samoanAttackTime : float = 0.1
const vikingAttackTime : float = 0.34
var meleeDamage : int
const africanMeleeDamage : int = 12
const chineseMeleeDamage : int = 14
const japaneseMeleeDamage : int = 12
const mexicanMeleeDamage : int = 10
const vikingMeleeDamage : int = 18
const samoanMeleeDamage : int = 12
var meleeHasHit : bool = false
var attacking : bool = false
var isHit : bool = false
var health : int = 100
var lives : int = 3
var isDead : bool = false
var _attack_collision

# Identification Variables
var playerCharacter : int = 0
var playerControllerIndex : int
var playerKeyboardIndex : int
var playercontroller : bool
var doubleKeyboard : bool
# Dictionaries
@onready var spawnLocations1 : Dictionary = {
	1 : spawnLocationAfrica1,
	2 : spawnLocationChina1,
	3 : spawnLocationJapan1,
	4 : spawnLocationSamoa1,
	5 : spawnLocationViking1,
	6 : spawnLocationMexico1,
	}
@onready var spawnLocations2 : Dictionary = {
	1 : spawnLocationAfrica2,
	2 : spawnLocationChina2,
	3 : spawnLocationJapan2,
	4 : spawnLocationSamoa2,
	5 : spawnLocationViking2,
	6 : spawnLocationMexico2,
	}
@onready var pistolTextures : Dictionary = {
	1 : africanPistolSprite,
	2 : chinesePistolSprite,
	3 : japanesePistolSprite,
	4 : samoanPistolSprite,
	5 : vikingPistolSprite,
	6 : mexicanPistolSprite,
	}
@onready var pistolMarkers : Dictionary = {
	1 : africanPistolMarker,
	2 : chinesePistolMarker,
	3 : japanesePistolMarker,
	4 : samoanPistolMarker,
	5 : vikingPistolMarker,
	6 : mexicanPistolMarker,
	}
@onready var attackCollisions : Dictionary = {
	1 : africanAttackCollision,
	2 : chineseAttackCollision,
	3 : japaneseAttackCollision,
	4 : samoanAttackCollision,
	5 : vikingAttackCollision,
	6 : mexicanAttackCollision,
	}
@onready var attackTimes : Dictionary = {
	1 : africanAttackTime,
	2 : chineseAttackTime,
	3 : japaneseAttackTime,
	4 : samoanAttackTime,
	5 : vikingAttackTime,
	6 : mexicanAttackTime,
	}
@onready var meleeDamages : Dictionary = {
	1 : africanMeleeDamage,
	2 : chineseMeleeDamage,
	3 : japaneseMeleeDamage,
	4 : samoanMeleeDamage,
	5 : vikingMeleeDamage,
	6 : mexicanMeleeDamage,
	}
var animation_map : Dictionary = {
	1: {"idle": "africanIdle", "walk": "africanWalk", "jump": "africanJump", "wall": "africanWall", "attack": "africanAttack"},
	2: {"idle": "chinaIdle", "walk": "chinaWalk", "jump": "chinaJump", "wall": "chinaWall", "attack": "chinaAttack"},
	3: {"idle": "japaneseIdle", "walk": "japaneseWalk", "jump": "japaneseJump", "wall": "japaneseWall", "attack": "japaneseAttack"},
	4: {"idle": "samoanIdle", "walk": "samoanWalk", "jump": "samoanJump", "wall": "samoanWall", "attack": "samoanAttack"},
	5: {"idle": "vikingIdle", "walk": "vikingWalk", "jump": "vikingJump", "wall": "vikingWall", "attack": "vikingAttack"},
	6: {"idle": "mexicanIdle", "walk": "mexicanWalk", "jump": "mexicanJump", "wall": "mexicanWall", "attack": "mexicanAttack"},
}
var weaponSwingPitch : Dictionary = {
	1 : 1,
	2 : 1,
	3 : 1,
	4 : 0.7,
	5 : 0.2,
	6 : 1.2,
}
func _ready():
	apply_player_variables()

func _physics_process(_delta):
	# Assigns Global Script Variables
	if playerIndex == 1:
		global_script.player1health = health
		global_script.globalPlayer1Lives = lives
	elif playerIndex == 2:
		global_script.player2health = health
		global_script.globalPlayer2Lives = lives
	if global_script.isPaused:
		_animated_sprite.stop()
	# Pauses all Movement when Paused / Dead
	if global_script.isPaused == false && isDead == false:
		# Applies Character Animation
		var anims = animation_map.get(playerCharacter, null)
		if velocity == Vector2(0, 0) && !attacking:
			_animated_sprite.play(anims["idle"])
		if is_on_floor() && !dashing && !attacking:
			if velocity.x > 0:
				_animated_sprite.play(anims["walk"])
			elif velocity.x < 0:
				_animated_sprite.play(anims["walk"])
		if !is_on_floor() && !attacking:
			_animated_sprite.play(anims["jump"])
		if is_on_wall() && !is_on_floor() && !attacking:
			_animated_sprite.play(anims["wall"])
		if velocity.x != 0 && is_on_floor():
			if !walkingAudioPlayer.playing:
				if global_script.soundOn:
					walkingAudioPlayer.play()
		else:
			walkingAudioPlayer.stop()
		# Checking if is Controller and Shoot
		if playercontroller:
			if hasGun:
				if Input.is_joy_button_pressed(playerControllerIndex, JOY_BUTTON_X) && !onWall:
					if !joyShootPressed:
						joyShootPressed = true
						shoot()
				else:
					joyShootPressed = false
			else:
				if Input.is_joy_button_pressed(playerControllerIndex, JOY_BUTTON_X) && !onWall:
					if !joyShootPressed:
						joyShootPressed = true
						attack()
				else:
					joyShootPressed = false
		else:
			if hasGun:
				# Changes Keyboard Input Depending on Keyboard Index
				if playerKeyboardIndex == 0:
					if Input.is_action_just_pressed("shoot") && !onWall:
							shoot()
				elif playerKeyboardIndex == 1:
					if Input.is_action_just_pressed("shoot2") && !onWall:
						shoot()
			else:
				# Changes Keyboard Input Depending on Keyboard Index
				if playerKeyboardIndex == 0:
					if Input.is_action_just_pressed("shoot") && !onWall:
						attack()
				elif playerKeyboardIndex == 1:
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
			if Input.is_joy_button_pressed(playerControllerIndex, JOY_BUTTON_B ):
				dash()
		else:
			if playerKeyboardIndex == 0:
				if Input.is_action_just_pressed("dash"):
					dash()
			elif playerKeyboardIndex == 1:
				if Input.is_action_just_pressed("dash2"):
					dash()
		# Gets Controller Joystick Input or Keyboard Input
		if playercontroller:
			directionInputX = Input.get_joy_axis(playerControllerIndex, JOY_AXIS_LEFT_X)
		else:
			# Changes Input based on Keyboard Index
			if playerKeyboardIndex == 0:
				directionInputX = Input.get_axis("move_left", "move_right")
			elif playerKeyboardIndex == 1:
				directionInputX = Input.get_axis("move_left2", "move_right2")
		# Adds Deadzone for Controller Joystick Input
		if abs(directionInputX) < deadzone:
			directionX = 0
		else:
			directionX = (directionInputX - sign(directionInputX) * deadzone) / (1 - deadzone)
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
		elif !isHit && directionX != 0 && !dashing:
			if attacking:
				velocity.x = velocity.x + (attackingAcceleration * directionX)
			else:
				velocity.x = velocity.x + (acceleration * directionX)
		# Limits Max Speed
		if velocity.x > maxSpeed:
			velocity.x = move_toward(velocity.x, 0, maxFriction)
		elif velocity.x < -maxSpeed:
			velocity.x = move_toward(velocity.x, 0, maxFriction)
		else:
			velocity.x = move_toward(velocity.x, 0, friction)
		# Detects if Player is Holding Down, to Move through One Way Platforms
		if playercontroller:
			directionInputY = Input.get_joy_axis(playerControllerIndex, JOY_AXIS_LEFT_Y)
			if abs(directionInputY) < deadzoneY:
				directionY = 0
			else:
				directionY = (directionInputY - sign(directionInputY) * deadzoneY) / (1 - deadzoneY)
			if directionY > 0:
				if is_on_floor():
					position.y += 1
		else:
			if playerKeyboardIndex == 0:
				if Input.is_action_pressed("move_down"):
					if is_on_floor():
						position.y += 1
			if playerKeyboardIndex == 1:
				if Input.is_action_pressed("move_down2"):
					if is_on_floor():
						position.y += 1
		# Reset Jumps and Velocity
		
		if velocity.y > 300:
			wasFalling = true
		if is_on_floor(): 
			if wasFalling:
				if global_script.soundOn:
					landingAudioPlayer.play()
				wasFalling = false
			doubleJumps = maxDoubleJumps
			velocity.y = 0
		if playercontroller:
			# Adds Jump button for Controller
			if Input.is_joy_button_pressed(playerControllerIndex, JOY_BUTTON_A) && !attacking:
				jump()
			else:
				joyJumpPressed = false
		else:
			# Player 1 Keyboard Jump Input
			if playerKeyboardIndex == 0:
				if !doubleKeyboard:
					# Adds Jump Button for Single Keyboard
					if (Input.is_action_just_pressed("jump") || Input.is_action_just_pressed("move_up")) && !attacking:
						jump()
					else:
						joyJumpPressed = false
				elif doubleKeyboard:
					# Adds Jump Button for Double Keyboard
					if Input.is_action_just_pressed("move_up") && !attacking:
						jump()
					else:
						joyJumpPressed = false
			elif playerKeyboardIndex == 1:
				# Player 1 Keyboard Jump Input
				if Input.is_action_just_pressed("move_up2") && !attacking:
					jump()
				else:
					joyJumpPressed = false
		# Wall Climbing
		if is_on_wall() && (directionX == -1 || directionX == 1) && !attacking:
			doubleJumps = maxDoubleJumps
			if velocity.y >= 0: 
				velocity.y = min(velocity.y + wallSlideAcceleration, maxWallSlideSpeed)
			else:
				velocity.y += gravity
				if velocity.y > maxGravity:
					velocity.y = maxGravity
		# Adds Gravity
		elif !is_on_floor():
			velocity.y += gravity
			if velocity.y > maxGravity:
				velocity.y = maxGravity
		# Removes Y Velocity When Dashing
		if dashing:
			velocity.y = 0
		# Sets Dash when on Ground or Wall
		if (is_on_floor() || onWall):
			currentDashAmount = dashAmount
		
		move_and_slide()
func apply_player_variables():
	if playerIndex == 1: # Assigns Player 1 Controller / Keyboard
		playercontroller = global_script.player1Controller
		if global_script.player1Controller:
			playerControllerIndex = 0
		elif !global_script.player1Controller:
			playerKeyboardIndex = 0
	if !global_script.player1Controller && !global_script.player2Controller:
		doubleKeyboard = true
	if playerIndex == 2: # Assigns Player 2 Controller / Keyboard
		if global_script.player1Controller && global_script.player2Controller:
			playerControllerIndex = 1
		elif global_script.player1Controller:
			playerKeyboardIndex = 0
		elif global_script.player2Controller:
			playerControllerIndex  = 0
		else:
			playerKeyboardIndex = 1
		playercontroller = global_script.player2Controller
	playerLabel.text = "Player: " + str(playerIndex)
	# Sets Different Variables for each character
	if playerIndex == 1:
		weaponSwingAudioPlayer.pitch_scale = weaponSwingPitch[global_script.globalPlayerCharacter1]
		playerCharacter = global_script.globalPlayerCharacter1
		spawnlocation1 = spawnLocations1[global_script.mapType]
		global_position = spawnlocation1.global_position
		gunSprite.texture = pistolTextures[global_script.globalPlayerCharacter1]
		normalPistolTexture = pistolTextures[global_script.globalPlayerCharacter1]
		normalPistolMarker = pistolMarkers[global_script.globalPlayerCharacter1]
		bulletMarker.position = pistolMarkers[global_script.globalPlayerCharacter1]
		_attack_collision = attackCollisions[global_script.globalPlayerCharacter1]
		attackTime = attackTimes[global_script.globalPlayerCharacter1]
		meleeDamage = meleeDamages[global_script.globalPlayerCharacter1]
	if playerIndex == 2:
		weaponSwingAudioPlayer.pitch_scale = weaponSwingPitch[global_script.globalPlayerCharacter2]
		playerCharacter = global_script.globalPlayerCharacter2
		spawnlocation2 = spawnLocations2[global_script.mapType]
		global_position = spawnlocation2.global_position
		gunSprite.texture = pistolTextures[global_script.globalPlayerCharacter2]
		normalPistolTexture = pistolTextures[global_script.globalPlayerCharacter2]
		normalPistolMarker = pistolMarkers[global_script.globalPlayerCharacter2]
		bulletMarker.position = pistolMarkers[global_script.globalPlayerCharacter2]
		_attack_collision = attackCollisions[global_script.globalPlayerCharacter2]
		attackTime = attackTimes[global_script.globalPlayerCharacter2]
		meleeDamage = meleeDamages[global_script.globalPlayerCharacter2]
	_attack_collision.disabled = true
	isDead = false
	hasGun = false
	shootCooldown = pistolCooldown
	health = 100
func jump():
	if !joyJumpPressed:
		joyJumpPressed = true
		if doubleJumps > 0: 
			if global_script.soundOn:
				jumpAudioPlayer.play()
			doubleJumps -= 1
			velocity.y = -jumpHeight
		if is_on_wall() && directionX == 1:
			if global_script.soundOn:
				jumpAudioPlayer.play()
			velocity.x = -(maxSpeed * 3)
		elif is_on_wall() && directionX == -1:
			if global_script.soundOn:
				jumpAudioPlayer.play()
			velocity.x = (maxSpeed * 3)
	
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
			if global_script.soundOn:
				pistolBulletAudioPlayer.play()
			if facingRight:
				bullet.bulletspawn(1, playerIndex, gunDamage, gunType)
			else:
				bullet.bulletspawn(-1, playerIndex, gunDamage, gunType)
		if gunType == 2:
			if global_script.soundOn:
				sniperBulletAudioPlayer.play()
			if facingRight:
				bullet.bulletspawn(1, playerIndex, sniperDamage, gunType)
			else:
				bullet.bulletspawn(-1, playerIndex, sniperDamage, gunType)
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
			if global_script.soundOn:
				dashAudioPlayer.play()
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
		if global_script.soundOn:
			weaponSwingAudioPlayer.play()
		# Attack Delay
		time_to_attack()
		attacking = true
		# Attack Animation
		var anims = animation_map.get(playerCharacter, null)
		_animated_sprite.play(anims["attack"])
	
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
		

func is_hit(attackerFacingRight : bool, damageDone : int):
	# Checks if Can be Hit
	if !isDead && !isHit:
		if global_script.soundOn:
			hitMarkerAudioPlayer.play()
		# Creates Damage Number
		global_script.display_damage_number(damageDone, damageNumberOrigin.global_position)
		# Health takes Damage
		health -= damageDone
		# Checks if Health is 0
		if health <= 0:
			# Emmits Death Particles
			killParticle.global_position = global_position
			killParticle.emitting = true
			die()
		else:
			var knockbackDirection : int
			if attackerFacingRight:
				knockbackDirection = 1
			elif !attackerFacingRight:
				knockbackDirection = -1
			# Adds Knockback
			take_knockback(damageDone, knockbackDirection, meleeKnockbackStrength)
			isHit = true
			_animated_sprite.self_modulate = Color(1, 0, 0) 
			# Creates Hit Timer
			await get_tree().create_timer(0.15).timeout
			isHit = false
			_animated_sprite.self_modulate = Color(1, 1, 1)
	

func _on_animated_sprite_2d_animation_finished():
	if (_animated_sprite.animation == "africanAttack" or _animated_sprite.animation == "chinaAttack" or _animated_sprite.animation == "japaneseAttack" or _animated_sprite.animation == "samoanAttack" or _animated_sprite.animation == "vikingAttack" or _animated_sprite.animation == "mexicanAttack"):
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
	return(playerIndex)

func bullet_hit(bulletDirection : int, damageDone : int, hitGunType : int):
	# When Hit by Bullet
	if !isDead && !isHit:
		if global_script.soundOn:
			hitMarkerAudioPlayer.play()
		# Sets Knockback Direction
		var knockbackDirection : int = bulletDirection
		# Creates Damage Number
		
		global_script.display_damage_number(damageDone, damageNumberOrigin.global_position)
		# Health takes Damage
		health -= damageDone
		# Checks if Dead
		if health <= 0:
			killParticle.global_position = global_position
			killParticle.emitting = true
			die()
		else:
			# Adds Knockback for Pistol
			if hitGunType == 1:
				take_knockback(damageDone, knockbackDirection, gunKnockbackStrength)
			# Adds Knockback for Sniper
			if hitGunType == 2:
				take_knockback(damageDone, knockbackDirection, sniperKnockbackStrength)
		isHit = true
		_animated_sprite.self_modulate = Color(1, 0, 0) 
		await get_tree().create_timer(0.15).timeout
		isHit = false
		_animated_sprite.self_modulate = Color(1, 1, 1)

func take_knockback(damageDone : int, direction : int, knockbackStrength : int):
	if direction > 0:
		velocity.x += (knockbackStrength * damageDone + 20 * pow((100 - health), 1.1))
	elif direction < 0:
		velocity.x -= (knockbackStrength * damageDone + 20 * pow((100 - health), 1.1))

func die():
	if global_script.soundOn:
		deathAudioPlayer.play()
	gunType = 0
	hasGun = false
	isDead = true
	self.visible = false
	health = 100
	lives -= 1
	if lives > 0:
		if playerIndex == 1:
			global_position = spawnlocation1.global_position
			velocity = Vector2(0, 0)
		elif playerIndex == 2:
			global_position = spawnlocation2.global_position
			velocity = Vector2(0, 0)
		await get_tree().create_timer(1).timeout
		isDead = false
		self.visible = true
		velocity = Vector2(0, 0)
	if lives <= 0:
		if playerIndex == 1:
			global_script.winningPlayer = 2
		elif playerIndex == 2:
			global_script.winningPlayer = 1
		WinText.text = "Player " + str(global_script.winningPlayer) + " Wins!"
		WinText.visible = true
		await get_tree().create_timer(0.1).timeout
		global_script.isPaused = true
		await get_tree().create_timer(1.5).timeout
		global_script.isPaused = false
		global_script.win_scene()

func collect_item(itemType : int):
	if global_script.soundOn:
		weaponPickupAudioPlayer.play()
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
