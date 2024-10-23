extends CharacterBody2D
# Nodes
@onready var global_script = $"/root/Global"
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
	random_int = randi_range(1, 5)
	if random_int == 2:
		large_crate_collision.disabled = false
		crate_collision.disabled = true
		large_crate_collision_2.disabled = false
		crate_collision_2.disabled = true
		sniper_texture.visible = true
		large_crate.visible = true
		gun_type = 2
	else:
		large_crate_collision.disabled = true
		crate_collision.disabled = false
		large_crate_collision_2.disabled = true
		crate_collision_2.disabled = false
		pistol_texture.visible = true
		crate.visible = true
		gun_type = 1


func _physics_process(_delta):
	if !global_script.is_paused:
		if not is_on_floor():
			velocity.y = 200
		move_and_slide()


func _on_area_2d_area_entered(area):
	if area.is_in_group("player"):
		var grandparent = area.get_parent().get_parent()
		if grandparent and grandparent.has_method("collect_item"):
			grandparent.collect_item(gun_type)
			queue_free()
	elif area.is_in_group("boundary"):
		global_script.crate_number -= 1
		queue_free()
