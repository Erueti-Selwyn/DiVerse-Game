extends CharacterBody2D


var SPEED = 325
var normal_speed = 325
var crouch_speed = 200

var dash_speed = 5000
var dash_duration = 0.2
var dash_cooldown = 2
const JUMP_VELOCITY = -600.0
var extra_jump = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta * 1.5
	else:
		extra_jump = true

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	else: 
		if Input.is_action_just_pressed("jump") and extra_jump:
			velocity.y = JUMP_VELOCITY
			extra_jump = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		if Input.is_action_just_pressed("dash"):
			velocity.x = direction * dash_speed
		else:
			velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	if Input.is_action_pressed("move_down"):
		scale.y = 1.25
		if is_on_floor():
			SPEED = crouch_speed
		else:
			SPEED = normal_speed
	else:
		scale.y = 2
		SPEED = normal_speed

		
