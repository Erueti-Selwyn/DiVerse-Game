extends CharacterBody2D


var speed = 400
var normalSpeed = 450
var crouchSpeed = 300
var crouching = false

var dashDirection = Vector2(0, 0)
var dashAmount = 1
var currentDashAmount = 0
var canDash = true
var dashing = false
var dashSpeed = 1700

const jumpVelocity = -600.0
var extraJumpAmount = 2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		if crouching:
			velocity.y += 3 * gravity * delta * 1.75
			if velocity.y > 900:
				velocity.y = 900
		else:
			velocity.y += gravity * delta * 1.5
	else:
		extraJumpAmount = 2

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jumpVelocity
	else: 
		if Input.is_action_just_pressed("jump") and extraJumpAmount > 0 and !crouching:
			velocity.y = jumpVelocity
			extraJumpAmount -= 1

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if Input.is_action_just_pressed("dash") and !dashing:
		dashDirection = direction
	if dashing:
		velocity.x = dashDirection * dashSpeed
	else:
		if direction and !dashing:
			velocity.x = direction * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
			
	if Input.is_action_pressed("move_down"):
		crouching = true
		if is_on_floor():
			position.y += 1
	else:
		crouching = false

	move_and_slide()
	dash()
		
func dash():
	if dashing:
		velocity.y = 0
	if is_on_floor():
		currentDashAmount = dashAmount
		
	if Input.is_action_just_pressed("dash") and currentDashAmount > 0 and !dashing and canDash:
		dashing = true
		canDash = false
		currentDashAmount -= 1
		await get_tree().create_timer(0.1).timeout
		dashing = false
		await get_tree().create_timer(0.5).timeout
		canDash = true




func _on_area_2d_body_entered(body):
	print("Hit Boundary")
	if body.is_in_group("boundary"):
		print("Hit The Boundary")
