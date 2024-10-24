extends CharacterBody2D

@onready var global_script = $"/root/Global"
# Nodes
@onready var sniper_texture = $sniper
@onready var pistol_texture = $pistol
@onready var crate = $crate
@onready var large_crate = $largeCrate
@onready var crate_collision = $Area2D/crateCollision
@onready var crate_collision_2 = $crateCollision2
@onready var large_crate_collision = $Area2D/largeCrateCollision
@onready var large_crate_collision_2 = $largeCrateCollision2
# Variables
var random_int : int
var gun_type : int


func _ready():
	# Generates random number for type of gun crate spawns.
	random_int = randi_range(1, 5)
	if random_int == 1:
		# If random_int is 1 spawns sniper.
		large_crate_collision.disabled = false
		crate_collision.disabled = true
		large_crate_collision_2.disabled = false
		crate_collision_2.disabled = true
		sniper_texture.visible = true
		large_crate.visible = true
		gun_type = 2
	else:
		# Spawns pistol
		large_crate_collision.disabled = true
		crate_collision.disabled = false
		large_crate_collision_2.disabled = true
		crate_collision_2.disabled = false
		pistol_texture.visible = true
		crate.visible = true
		gun_type = 1


func _physics_process(_delta):
	# Adds velocity if not paused.
	if not global_script.is_paused:
		if not is_on_floor():
			velocity.y = 200
		move_and_slide()


func _on_area_2d_area_entered(area):
	# Checks if collided area is player.
	if area.is_in_group("player"):
		# Gets player script.
		var grandparent = area.get_parent().get_parent()
		if grandparent and grandparent.has_method("collect_item"):
			grandparent.collect_item(gun_type)
			queue_free()
	elif area.is_in_group("boundary"):
		# Deletes crate if hit boundary
		global_script.crate_number -= 1
		queue_free()
