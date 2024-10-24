extends CharacterBody2D

@export var player_index : int = 1
# Assets
const AFRICAN_PISTOL_SPRITE = preload("res://assets/guns/africanpistol.png")
const CHINESE_PISTOL_SPRITE = preload("res://assets/guns/chinesepistol.png")
const JAPANESE_PISTOL_SPRITE = preload("res://assets/guns/japanesepistol.png")
const MEXICAN_PISTOL_SPRITE = preload("res://assets/guns/mexicanpistol.png")
const VIKING_PISTOL_SPRITE = preload("res://assets/guns/norwegianpistol.png")
const SAMOAN_PISTOL_SPRITE = preload("res://assets/guns/polynesianpistol.png")
const SNIPER_SPRITE = preload("res://assets/guns/sniper.png")
const BULLET_PATH = preload("res://scenes/bullet.tscn")

# Nodes
@onready var global_script = $"/root/Global"
@onready var animated_sprite : AnimatedSprite2D = $CollisionShape2D/AnimatedSprite2D
@onready var gun : Sprite2D = $CollisionShape2D/AnimatedSprite2D/Gun
@onready var african_attack_collision : CollisionShape2D = $CollisionShape2D/AnimatedSprite2D/Melee/AfricanAttackCollision
@onready var chinese_attack_collision : CollisionShape2D = $CollisionShape2D/AnimatedSprite2D/Melee/ChineseAttackCollision
@onready var japanese_attack_collision : CollisionShape2D = $CollisionShape2D/AnimatedSprite2D/Melee/JapaneseAttackCollision
@onready var mexican_attack_collision : CollisionShape2D = $CollisionShape2D/AnimatedSprite2D/Melee/MexicanAttackCollision
@onready var samoan_attack_collision : CollisionShape2D = $CollisionShape2D/AnimatedSprite2D/Melee/SamoanAttackCollision
@onready var viking_attack_collision : CollisionShape2D = $CollisionShape2D/AnimatedSprite2D/Melee/VikingAttackCollision
@onready var gun_sprite : Sprite2D = $"CollisionShape2D/AnimatedSprite2D/Gun"
@onready var player_label : Label = $"Label"
@onready var muzzle_flash : CPUParticles2D = $CollisionShape2D/AnimatedSprite2D/Gun/Marker2D/MuzzleFlashPistol
@onready var bullet_marker : Marker2D = $CollisionShape2D/AnimatedSprite2D/Gun/Marker2D
@onready var walk_particle : CPUParticles2D= $CollisionShape2D/AnimatedSprite2D/WalkParticle
@onready var spawn_location_africa_1 : Marker2D = $"../SpawnLocationAfrica1"
@onready var spawn_location_africa_2 : Marker2D = $"../SpawnLocationAfrica2"
@onready var spawn_location_china_1 : Marker2D = $"../SpawnLocationChina1"
@onready var spawn_location_china_2 : Marker2D = $"../SpawnLocationChina2"
@onready var spawn_location_japan_1 : Marker2D = $"../SpawnLocationJapan1"
@onready var spawn_location_japan_2 : Marker2D = $"../SpawnLocationJapan2"
@onready var spawn_location_samoa_1 : Marker2D = $"../SpawnLocationSamoa1"
@onready var spawn_location_samoa_2 : Marker2D = $"../SpawnLocationSamoa2"
@onready var spawn_location_mexico_1 : Marker2D = $"../SpawnLocationMexico1"
@onready var spawn_location_mexico_2 : Marker2D = $"../SpawnLocationMexico2"
@onready var spawn_location_viking_1 : Marker2D = $"../SpawnLocationViking1"
@onready var spawn_location_viking_2 : Marker2D = $"../SpawnLocationViking2"
@onready var win_text : Label = $"../WinText"
@onready var fall_particle : CPUParticles2D = $"../fallSplashParticle"
@onready var kill_particle : CPUParticles2D = $"../killParticle"
@onready var damage_number_origin : Node2D = $CollisionShape2D/AnimatedSprite2D/DamageNumberOrigin
@onready var dash_audio_player : AudioStreamPlayer2D = $"DashAudioPlayer"
@onready var death_audio_player : AudioStreamPlayer2D= $"DeathAudioPlayer"
@onready var hit_marker_audio_player : AudioStreamPlayer2D = $"HitMarkerAudioPlayer"
@onready var jump_audio_player : AudioStreamPlayer2D = $"JumpAudioPlayer"
@onready var landing_audio_player : AudioStreamPlayer2D = $LandingAudioPlayer
@onready var pistol_bullet_audio_player : AudioStreamPlayer2D = $"PistolBulletAudioPlayer"
@onready var sniper_bullet_audio_player : AudioStreamPlayer2D = $"SniperBulletAudioPlayer"
@onready var walking_audio_player : AudioStreamPlayer2D = $"WalkingAudioPlayer"
@onready var weapon_pick_up_audio_player : AudioStreamPlayer2D = $"WeaponPickupAudioPlayer"
@onready var weapon_swing_audio_player : AudioStreamPlayer2D = $"WeaponSwingAudioPlayer"

# Movement variables
const MAX_SPEED : int= 450
const ACCELERATION : int = 120
const ATTACKING_ACCELERATION : int = 60
const MAX_FRICTION : int = 225
const FRICTION : int = 30
const JUMP_HEIGHT : int = 600
const GRAVITY : int = 30
const MAX_GRAVITY : int = 1000
const MAX_DOUBLE_JUMPS : int = 3 
const WALL_SLIDE_ACCELERATION : int = 10
const MAX_WALL_SLIDE_SPEED : int = 40
var on_wall : bool = false
var double_jumps: int = 0
var dash_direction : float = 0
var dash_amount : int = 1
var current_dash_amount : int = 0
var can_dash : bool= true
var dashing : bool= false
var dash_speed : int = 1250
var was_falling : bool = false
# Input variables
var jump_pressed : bool = false
var shoot_pressed : bool = false
var direction_x : float
var direction_y : float
var direction_input_x : float
var direction_input_y : float
const DEADZONE : float = 0.2
const DEADZONE_Y : float = 0.9
var facing_right : bool = true
# Gun variables
var shoot_cooldown : float
const PISTOL_COOLDOWN : float = 0.15
const SNIPER_COOLDOWN : float = 0.7
var can_shoot : bool = true
var has_gun : bool = false
var gun_type : int
const TOTAL_PISTOL_BULLETS : int = 12
const TOTAL_SNIPER_BULLETS : int = 5
var bullets_left : int = 0
const PISTOL_DAMAGE : int = 6
const SNIPER_DAMAGE : int = 30
const AFRICAN_PISTOL_MARKER = Vector2(14.429,-2.571)
const CHINESE_PISTOL_MARKER = Vector2(11.571, -4)
const JAPANESE_PISTOL_MARKER = Vector2(14.429, -8.286)
const MEXICAN_PISTOL_MARKER = Vector2(14.429, 0.286)
const VIKING_PISTOL_MARKER = Vector2(14.429, -1.143)
const SAMOAN_PISTOL_MARKER = Vector2(14.429, -4)
const SNIPER_MARKER = Vector2(27.286, -2.571)
var normal_pistol_texture
var normal_pistol_marker

# Attacking variables
const MELEE_KNOCKBACK_STRENGTH : int = 75
const PISTOL_KNOCKBACK_STRENGTH : int = 150
const SNIPER_KNOCKBACK_STRENGTH : int= 50
var attack_time : float
const AFRICAN_ATTACK_TIME : float = 0.09
const CHINESE_ATTACK_TIME : float = 0.1
const JAPANESE_ATTACK_TIME : float = 0.125
const MEXICAN_ATTACK_TIME : float = 0
const SAMOAN_ATTACK_TIME : float = 0.1
const VIKING_ATTACK_TIME : float = 0.34
var melee_damage : int
const AFRICAN_MELEE_DAMAGE : int = 12
const CHINESE_MELEE_DAMAGE : int = 14
const JAPANESE_MELEE_DAMAGE : int = 12
const MEXICAN_MELEE_DAMAGE : int = 10
const VIKING_MELEE_DAMAGE : int = 18
const SAMOAN_MELEE_DAMAGE : int = 12
var melee_has_hit : bool = false
var attacking : bool = false
var is_hit : bool = false
var health : int = 100
var lives : int = 3
var is_dead : bool = false
var attack_collision

# Identification variables
var player_character : int = 0
var player_controller_index : int
var player_keyboard_index : int
var player_controller : bool
var double_keyboard : bool
var spawn_location_1 : Marker2D
var spawn_location_2 : Marker2D
# Dictionaries
@onready var spawn_locations_1_dict : Dictionary = {
	1 : spawn_location_africa_1,
	2 : spawn_location_china_1,
	3 : spawn_location_japan_1,
	4 : spawn_location_samoa_1,
	5 : spawn_location_viking_1,
	6 : spawn_location_mexico_1,
	}
@onready var spawn_locations_2_dict : Dictionary = {
	1 : spawn_location_africa_2,
	2 : spawn_location_china_2,
	3 : spawn_location_japan_2,
	4 : spawn_location_samoa_2,
	5 : spawn_location_viking_2,
	6 : spawn_location_mexico_2,
	}
@onready var pistol_textures_dict : Dictionary = {
	1 : AFRICAN_PISTOL_SPRITE,
	2 : CHINESE_PISTOL_SPRITE,
	3 : JAPANESE_PISTOL_SPRITE,
	4 : SAMOAN_PISTOL_SPRITE,
	5 : VIKING_PISTOL_SPRITE,
	6 : MEXICAN_PISTOL_SPRITE,
	}
@onready var pistol_markers_dict : Dictionary = {
	1 : AFRICAN_PISTOL_MARKER,
	2 : CHINESE_PISTOL_MARKER,
	3 : JAPANESE_PISTOL_MARKER,
	4 : SAMOAN_PISTOL_MARKER,
	5 : VIKING_PISTOL_MARKER,
	6 : MEXICAN_PISTOL_MARKER,
	}
@onready var attack_collisions_dict : Dictionary = {
	1 : african_attack_collision,
	2 : chinese_attack_collision,
	3 : japanese_attack_collision,
	4 : samoan_attack_collision,
	5 : viking_attack_collision,
	6 : mexican_attack_collision,
	}
@onready var attack_times_dict : Dictionary = {
	1 : AFRICAN_ATTACK_TIME,
	2 : CHINESE_ATTACK_TIME,
	3 : JAPANESE_ATTACK_TIME,
	4 : SAMOAN_ATTACK_TIME,
	5 : VIKING_ATTACK_TIME,
	6 : MEXICAN_ATTACK_TIME,
	}
@onready var melee_damages_dict : Dictionary = {
	1 : AFRICAN_MELEE_DAMAGE,
	2 : CHINESE_MELEE_DAMAGE,
	3 : JAPANESE_MELEE_DAMAGE,
	4 : SAMOAN_MELEE_DAMAGE,
	5 : VIKING_MELEE_DAMAGE,
	6 : MEXICAN_MELEE_DAMAGE,
	}
var animation_map_dict : Dictionary = {
	1: {"idle": "africanIdle", "walk": "africanWalk", "jump": "africanJump", "wall": "africanWall", "attack": "africanAttack"},
	2: {"idle": "chinaIdle", "walk": "chinaWalk", "jump": "chinaJump", "wall": "chinaWall", "attack": "chinaAttack"},
	3: {"idle": "japaneseIdle", "walk": "japaneseWalk", "jump": "japaneseJump", "wall": "japaneseWall", "attack": "japaneseAttack"},
	4: {"idle": "samoanIdle", "walk": "samoanWalk", "jump": "samoanJump", "wall": "samoanWall", "attack": "samoanAttack"},
	5: {"idle": "vikingIdle", "walk": "vikingWalk", "jump": "vikingJump", "wall": "vikingWall", "attack": "vikingAttack"},
	6: {"idle": "mexicanIdle", "walk": "mexicanWalk", "jump": "mexicanJump", "wall": "mexicanWall", "attack": "mexicanAttack"},
}
var weapon_swing_pitch_dict : Dictionary = {
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
	# Assigns global script variables.
	if player_index == 1:
		global_script.player_1_health = health
		global_script.global_player_1_lives = lives
	elif player_index == 2:
		global_script.player_2_health = health
		global_script.global_player_2_lives = lives
	if global_script.is_paused:
		animated_sprite.stop()
	# Pauses all movement when paused or dead.
	if (
		not global_script.is_paused
		and not is_dead
	):
		# Applies character animation based on player character.
		var anims = animation_map_dict.get(player_character, null)
		if (
			velocity == Vector2(0, 0) 
			and not attacking
		):
			animated_sprite.play(anims["idle"])
		if (
			is_on_floor() 
			and not dashing 
			and not attacking
		):
			if velocity.x > 0:
				animated_sprite.play(anims["walk"])
			elif velocity.x < 0:
				animated_sprite.play(anims["walk"])
		if (
			not is_on_floor() 
			and not attacking
		):
			animated_sprite.play(anims["jump"])
		if (
			is_on_wall() 
			and not is_on_floor() 
			and not attacking
		):
			animated_sprite.play(anims["wall"])
		if (
			velocity.x != 0 
			and is_on_floor()
		):
			if not walking_audio_player.playing:
				if global_script.sound_on:
					walking_audio_player.play()
		else:
			walking_audio_player.stop()
		# checking if is controller and shoot input.
		if player_controller:
			if has_gun:
				if (
					Input.is_joy_button_pressed(player_controller_index, JOY_BUTTON_X) 
					and not on_wall
				):
					if not shoot_pressed:
						shoot_pressed = true
						shoot()
				else:
					shoot_pressed = false
			else:
				if (
					Input.is_joy_button_pressed(player_controller_index, JOY_BUTTON_X) 
					and not on_wall
				):
					if not shoot_pressed:
						shoot_pressed = true
						attack()
				else:
					shoot_pressed = false
		else:
			if has_gun:
				# Changes keyboard input depending on keyboard index.
				if player_keyboard_index == 0:
					if (
						Input.is_action_just_pressed("shoot") 
						and not on_wall
					):
							shoot()
				elif player_keyboard_index == 1:
					if (
						Input.is_action_just_pressed("shoot2") 
						and not on_wall
					):
						shoot()
			else:
				# Changes keyboard input depending on keyboard index.
				if player_keyboard_index == 0:
					if (
						Input.is_action_just_pressed("shoot") 
						and not on_wall
					):
						attack()
				elif player_keyboard_index == 1:
					if (
						Input.is_action_just_pressed("shoot2") 
						and not on_wall
					):
						attack()
		# Adds walking particle.
		if (
			velocity.x != 0 
			and is_on_floor()
		):
			walk_particle.emitting = true
		else:
			walk_particle.emitting = false
		# Shows or hides gun based on variables.
		if has_gun:
			if (
				on_wall 
				or attacking
			):
				gun.visible = false
			else:
				gun.visible = true
		else:
			gun.visible = false
		# Sets on wall variable.
		if (
			is_on_wall() 
			and not is_on_floor() 
			and not attacking
		):
			on_wall = true
		else:
			on_wall = false
		if (
			facing_right 
			and not attacking
		):
			animated_sprite.scale.x = 1
		elif (
			not facing_right 
			and not attacking
		):
			animated_sprite.scale.x = -1

		# Detects dash input and calls dash function.
		if player_controller:
			if Input.is_joy_button_pressed(player_controller_index, JOY_BUTTON_B):
				dash()
		else:
			if player_keyboard_index == 0:
				if Input.is_action_just_pressed("dash"):
					dash()
			elif player_keyboard_index == 1:
				if Input.is_action_just_pressed("dash2"):
					dash()
		# Gets controller joystick input or keyboard input.
		if player_controller:
			direction_input_x = Input.get_joy_axis(player_controller_index, JOY_AXIS_LEFT_X)
		else:
			# Changes input based on keyboard index.
			if player_keyboard_index == 0:
				direction_input_x = Input.get_axis("move_left", "move_right")
			elif player_keyboard_index == 1:
				direction_input_x = Input.get_axis("move_left2", "move_right2")
		# Adds deadzone for controller joystick input.
		if abs(direction_input_x) < DEADZONE:
			direction_x = 0
		else:
			direction_x = (direction_input_x - sign(direction_input_x) * DEADZONE) / (1 - DEADZONE)
			direction_x = sign(direction_x)
			# Changes facing direction based on movement input.
			if direction_x > 0:
				facing_right = true
			elif direction_x < 0:
				facing_right = false
		# Adds dashing velocity when dashing.
		if (
			dashing 
			and not is_hit
		):
				velocity.x = dash_speed * dash_direction
		# Adds movement and acceleration.
		elif (
			not is_hit 
			and direction_x != 0 
			and not dashing
		):
			if attacking:
				velocity.x = velocity.x + (ATTACKING_ACCELERATION * direction_x)
			else:
				velocity.x = velocity.x + (ACCELERATION * direction_x)
		# Limits max speed.
		if velocity.x > MAX_SPEED:
			velocity.x = move_toward(velocity.x, 0, MAX_FRICTION)
		elif velocity.x < -MAX_SPEED:
			velocity.x = move_toward(velocity.x, 0, MAX_FRICTION)
		else:
			velocity.x = move_toward(velocity.x, 0, FRICTION)
		# Detects if player is holding down, to move through one way platforms.
		if player_controller:
			# For controller input.
			direction_input_x = Input.get_joy_axis(player_controller_index, JOY_AXIS_LEFT_Y)
			if abs(direction_input_y) < DEADZONE_Y:
				direction_y = 0
			else:
				direction_y = (direction_input_y - sign(direction_input_y) * DEADZONE_Y) / (1 - DEADZONE_Y)
			if direction_y > 0:
				if is_on_floor():
					position.y += 1
		else:
			# For keyboard input.
			if player_keyboard_index == 0:
				if Input.is_action_pressed("move_down"):
					if is_on_floor():
						position.y += 1
			if player_keyboard_index == 1:
				if Input.is_action_pressed("move_down2"):
					if is_on_floor():
						position.y += 1
		# Reset jumps and velocity, and adds landing sound effect.
		if velocity.y > 300:
			was_falling = true
		if is_on_floor(): 
			if was_falling:
				if global_script.sound_on:
					landing_audio_player.play()
				was_falling = false
			double_jumps = MAX_DOUBLE_JUMPS
			velocity.y = 0
		if player_controller:
			# Adds jump button for controller.
			if (
				Input.is_joy_button_pressed(player_controller_index, JOY_BUTTON_A) 
				and not attacking
			):
				jump()
			else:
				jump_pressed = false
		else:
			# Player 1 keyboard jump input.
			if player_keyboard_index == 0:
				if not double_keyboard:
					# Adds jump button for single keyboard.
					if (
						Input.is_action_just_pressed("jump") 
						or Input.is_action_just_pressed("move_up") 
						and not attacking
					):
						jump()
					else:
						jump_pressed = false
				elif double_keyboard:
					# Adds jump button for double keyboard
					if (
						Input.is_action_just_pressed("move_up") 
						and not attacking
					):
						jump()
					else:
						jump_pressed = false
			elif player_keyboard_index == 1:
				# Player 1 keyboard jump input.
				if (
					Input.is_action_just_pressed("move_up2") 
					and not attacking
				):
					jump()
				else:
					jump_pressed = false
		# Wall climbing.
		# Checks if on wall
		if (
			is_on_wall() 
			and (direction_x == -1 or direction_x == 1) 
			and not attacking
		):
			# Resets jumps
			double_jumps = MAX_DOUBLE_JUMPS
			if velocity.y >= 0: 
				# Adds jump velocity
				velocity.y = min(velocity.y + WALL_SLIDE_ACCELERATION, MAX_WALL_SLIDE_SPEED)
			else:
				velocity.y += GRAVITY
				if velocity.y > MAX_GRAVITY:
					velocity.y = MAX_GRAVITY
		# Adds gravity.
		elif not is_on_floor():
			velocity.y += GRAVITY
			if velocity.y > MAX_GRAVITY:
				velocity.y = MAX_GRAVITY
		# Removes Y velocity when dashing.
		if dashing:
			velocity.y = 0
		# Sets dash when on ground or wall.
		if (
			is_on_floor() 
			or on_wall
		):
			current_dash_amount = dash_amount
		
		move_and_slide()


func apply_player_variables():
	if player_index == 1: # Assigns player 1 controller or keyboard.
		player_controller = global_script.player_1_controller
		if global_script.player_1_controller:
			player_controller_index = 0
		elif not global_script.player_1_controller:
			player_keyboard_index = 0
	if (
		not global_script.player_1_controller 
		and not global_script.player_2_controller
	):
		double_keyboard = true
	if player_index == 2: # Assigns player 2 controller or keyboard
		if (
			global_script.player_1_controller 
			and global_script.player_2_controller
		):
			player_controller_index = 1
		elif global_script.player_1_controller:
			player_keyboard_index = 0
		elif global_script.player_2_controller:
			player_controller_index  = 0
		else:
			player_keyboard_index = 1
		player_controller = global_script.player_2_controller
	player_label.text = "Player: " + str(player_index)
	# Sets different variables for each character.
	if player_index == 1:
		weapon_swing_audio_player.pitch_scale = weapon_swing_pitch_dict[global_script.global_player_character_1]
		player_character = global_script.global_player_character_1
		spawn_location_1 = spawn_locations_1_dict[global_script.map_type]
		global_position = spawn_location_1.global_position
		gun_sprite.texture = pistol_textures_dict[global_script.global_player_character_1]
		normal_pistol_texture = pistol_textures_dict[global_script.global_player_character_1]
		normal_pistol_marker = pistol_markers_dict[global_script.global_player_character_1]
		bullet_marker.position = pistol_markers_dict[global_script.global_player_character_1]
		attack_collision = attack_collisions_dict[global_script.global_player_character_1]
		attack_time = attack_times_dict[global_script.global_player_character_1]
		melee_damage = melee_damages_dict[global_script.global_player_character_1]
	if player_index == 2:
		weapon_pick_up_audio_player.pitch_scale = weapon_swing_pitch_dict[global_script.global_player_character_2]
		player_character = global_script.global_player_character_2
		spawn_location_2 = spawn_locations_2_dict[global_script.map_type]
		global_position = spawn_location_2.global_position
		gun_sprite.texture = pistol_textures_dict[global_script.global_player_character_2]
		normal_pistol_texture = pistol_textures_dict[global_script.global_player_character_2]
		normal_pistol_marker = pistol_markers_dict[global_script.global_player_character_2]
		bullet_marker.position = pistol_markers_dict[global_script.global_player_character_2]
		attack_collision = attack_collisions_dict[global_script.global_player_character_2]
		attack_time = attack_times_dict[global_script.global_player_character_2]
		melee_damage = melee_damages_dict[global_script.global_player_character_2]
	# Sets variables.
	attack_collision.disabled = true
	is_dead = false
	has_gun = false
	shoot_cooldown = PISTOL_COOLDOWN
	health = 100


func jump():
	# jump_pressed makes it so player cannot hold down button. 
	if not jump_pressed:
		jump_pressed = true
		if double_jumps > 0: 
			if global_script.sound_on:
				jump_audio_player.play()
			double_jumps -= 1
			velocity.y = -JUMP_HEIGHT
		if (
			is_on_wall() 
			and direction_x == 1
		):
			if global_script.sound_on:
				jump_audio_player.play()
			velocity.x = -(MAX_SPEED * 3)
		elif (
			is_on_wall() 
			and direction_x == -1
		):
			if global_script.sound_on:
				jump_audio_player.play()
			velocity.x = (MAX_SPEED * 3)


func shoot(): 
	# Checks if can shoot.
	if (
		can_shoot 
		and bullets_left > 0 
		and has_gun 
		and not attacking
	):
		bullets_left -= 1
		if bullets_left <= 0:
			# Removes gun when no ammo.
			has_gun = false
		# Muzzle flash.
		muzzle_flash.emitting = true
		# Instantiate's bullet.
		var bullet = BULLET_PATH.instantiate()
		# Changes bullet variable based on gun type.
		if gun_type == 1:
			if global_script.sound_on:
				pistol_bullet_audio_player.play()
			if facing_right:
				bullet.bullet_spawn(1, player_index, PISTOL_DAMAGE, gun_type)
			else:
				bullet.bullet_spawn(-1, player_index, PISTOL_DAMAGE, gun_type)
		if gun_type == 2:
			if global_script.sound_on:
				sniper_bullet_audio_player.play()
			if facing_right:
				bullet.bullet_spawn(1, player_index, SNIPER_DAMAGE, gun_type)
			else:
				bullet.bullet_spawn(-1, player_index, SNIPER_DAMAGE, gun_type)
		# Moves bullet to marker.
		bullet.global_position = bullet_marker.global_position
		# Adds bullet to parent.
		get_parent().add_child(bullet)
		# Adds shot delay.
		if has_gun:
			can_shoot = false
			await get_tree().create_timer(shoot_cooldown).timeout
			can_shoot = true


func dash():
	# Checks if can dash.
	if (
		not attacking 
		and not is_hit
	):
		if not dashing:
			# Sets dash direction.
			if facing_right:
				dash_direction = 1
			else:
				dash_direction = -1
		# Checks if dash is avalible.
		if (
			current_dash_amount > 0 
			and not dashing 
			and can_dash
		):
			if global_script.sound_on:
				dash_audio_player.play()
			dashing = true
			can_dash = false
			current_dash_amount -= 1
			# Dash time.
			await get_tree().create_timer(0.1).timeout
			dashing = false
			# Dash cooldown
			await get_tree().create_timer(0.5).timeout
			can_dash = true


func attack():
	# Checks if can attack.
	if (
		not attacking 
		and not dashing
	):
		# Checks if sound on, and plays sound.
		if global_script.sound_on:
			weapon_swing_audio_player.play()
		# Adds attack delay.
		time_to_attack()
		attacking = true
		# Plays attack animation.
		var anims = animation_map_dict.get(player_character, null)
		animated_sprite.play(anims["attack"])


func time_to_attack():
	# Time for attack to activate.
	await get_tree().create_timer(attack_time).timeout
	attack_collision.disabled = false


func _on_melee_body_entered(body):
	# Melee hit detection.
	if (
		body.is_in_group("player") 
		and not melee_has_hit
	):
		# Sends attacker location and melee damage.
		body.melee_hit(facing_right, melee_damage, player_index)
		melee_has_hit = true


func melee_hit(attacker_facing_right : bool, damage_done : int, attacker_player_index : int):
	# Checks if can be hit.
	if (
		not is_dead 
		and not is_hit 
		and player_index != attacker_player_index
	):
		if global_script.sound_on:
			hit_marker_audio_player.play()
		# Creates damage number.
		global_script.display_damage_number(damage_done, damage_number_origin.global_position)
		# Health takes damage.
		health -= damage_done
		# Checks if health is 0.
		if health <= 0:
			# Emmits death particles.
			kill_particle.global_position = global_position
			kill_particle.emitting = true
			die()
		else:
			var knockback_direction : int
			if attacker_facing_right:
				knockback_direction = 1
			elif not attacker_facing_right:
				knockback_direction = -1
			# Adds knockback.
			take_knockback(damage_done, knockback_direction, MELEE_KNOCKBACK_STRENGTH)
			is_hit = true
			animated_sprite.self_modulate = Color(1, 0, 0) 
			# Creates hit timer.
			await get_tree().create_timer(0.15).timeout
			is_hit = false
			animated_sprite.self_modulate = Color(1, 1, 1)


func _on_animated_sprite_2d_animation_finished():
	if (
		animated_sprite.animation == "africanAttack" 
		or animated_sprite.animation == "chinaAttack" 
		or animated_sprite.animation == "japaneseAttack" 
		or animated_sprite.animation == "samoanAttack" 
		or animated_sprite.animation == "vikingAttack" 
		or animated_sprite.animation == "mexicanAttack"
	):
		# Starts when attack finishes.
		melee_has_hit = false
		attack_collision.disabled = true
		attacking = false


func _on_area_2d_area_entered(area):
	# Checks if hit boundary.
	if area.is_in_group("boundary"):
		# Summons fall particles.
		fall_particle.global_position.x = global_position.x
		fall_particle.emitting = true
		die()


func get_player_index():
	# Returns player index.
	return(player_index)


func bullet_hit(bullet_direction : int, damage_done : int, hit_gun_type : int):
	# When hit by bullet.
	if (
		not is_dead 
		and not is_hit
	):
		if global_script.sound_on:
			hit_marker_audio_player.play()
		# Sets knockback direction.
		var knockback_direction : int = bullet_direction
		# Creates damage number.
		
		global_script.display_damage_number(damage_done, damage_number_origin.global_position)
		# Health takes damage
		health -= damage_done
		# Checks if dead.
		if health <= 0:
			kill_particle.global_position = global_position
			kill_particle.emitting = true
			die()
		else:
			# Adds knockback for pistol.
			if hit_gun_type == 1:
				take_knockback(damage_done, knockback_direction, PISTOL_KNOCKBACK_STRENGTH)
			# Adds knockback for sniper.
			if hit_gun_type == 2:
				take_knockback(damage_done, knockback_direction, SNIPER_KNOCKBACK_STRENGTH)
		is_hit = true
		animated_sprite.self_modulate = Color(1, 0, 0) 
		await get_tree().create_timer(0.15).timeout
		is_hit = false
		animated_sprite.self_modulate = Color(1, 1, 1)


func take_knockback(damage_done : int, direction : int, knockback_strength : int):
	# Applies knockback.
	if direction > 0:
		velocity.x += (knockback_strength * damage_done + 20 * pow((100 - health), 1.1))
	elif direction < 0:
		velocity.x -= (knockback_strength * damage_done + 20 * pow((100 - health), 1.1))


func die():
	# Plays when health reaches 0 or player falls off map.
	if global_script.sound_on:
		death_audio_player.play()
	gun_type = 0
	has_gun = false
	is_dead = true
	self.visible = false
	health = 100
	lives -= 1
	if lives > 0:
		# If player still has lives, respawns at spawn location.
		if player_index == 1:
			global_position = spawn_location_1.global_position
			velocity = Vector2(0, 0)
		elif player_index == 2:
			global_position = spawn_location_2.global_position
			velocity = Vector2(0, 0)
		await get_tree().create_timer(1).timeout
		is_dead = false
		self.visible = true
		velocity = Vector2(0, 0)
	if lives <= 0:
		# If player has no lives, grants winning player and ends game.
		if player_index == 1:
			global_script.winning_player = 2
		elif player_index == 2:
			global_script.winning_player = 1
		win_text.text = "Player " + str(global_script.winning_player) + " Wins!"
		win_text.visible = true
		await get_tree().create_timer(0.1).timeout
		global_script.is_paused = true
		await get_tree().create_timer(1.5).timeout
		global_script.is_paused = false
		global_script.load_win_scene()


func collect_item(item_type : int):
	# When player collects crate.
	if global_script.sound_on:
		weapon_pick_up_audio_player.play()
	global_script.crate_number -= 1
	gun_type = item_type
	if item_type == 1:
		# Collecting pistol.
		has_gun = true
		can_shoot = true
		gun_sprite.texture = normal_pistol_texture
		bullet_marker.position = normal_pistol_marker
		shoot_cooldown = PISTOL_COOLDOWN
		bullets_left = TOTAL_PISTOL_BULLETS
	elif item_type == 2:
		# Collecting sniper.
		has_gun = true
		can_shoot = true
		gun_sprite.texture = SNIPER_SPRITE
		bullet_marker.position = SNIPER_MARKER
		shoot_cooldown = SNIPER_COOLDOWN
		bullets_left = TOTAL_SNIPER_BULLETS
