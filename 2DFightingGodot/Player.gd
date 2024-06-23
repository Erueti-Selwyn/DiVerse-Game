extends CharacterBody2D


var speed = 325
var normalSpeed = 325
var crouchSpeed = 200

var dashDirection = Vector2(0, 0)
var canDash = false
var dashing = false
var dashSpeed = 1500

const jumpVelocity = -600.0
var extraJump = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta * 1.5
	else:
		extraJump = true

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jumpVelocity
	else: 
		if Input.is_action_just_pressed("jump") and extraJump:
			velocity.y = jumpVelocity
			extraJump = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	dashDirection = direction
	if dashing:
		velocity.x = dashDirection * dashSpeed
	else:
		if direction and !dashing:
			velocity.x = direction * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	crouch()
	dash()
	
func crouch():
	if Input.is_action_pressed("move_down"):
		scale.y = -1.5
		if is_on_floor():
			speed = crouchSpeed
		else:
			speed = normalSpeed
	else:
		scale.y = -2
		speed = normalSpeed
		
func dash():
	if is_on_floor():
		canDash = true
		
	if Input.is_action_just_pressed("dash") and canDash and !is_on_floor():
		canDash = false
		dashing = true
		await get_tree().create_timer(0.1).timeout
		dashing = false
