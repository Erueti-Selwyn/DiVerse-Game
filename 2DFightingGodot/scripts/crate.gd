extends CharacterBody2D
@onready var global_script = $"/root/Global"
@onready var sniperTexture = $sniper
@onready var pistolTexture = $pistol
@onready var crate = $crate
@onready var largeCrate = $largeCrate
@onready var crateCollision = $Area2D/crateCollision
@onready var crateCollision2 = $crateCollision2
@onready var largeCrateCollision = $Area2D/largeCrateCollision
@onready var largeCrateCollision2 = $largeCrateCollision2
var randomint
var gunType
func _ready():
	randomint = randi_range(1, 2)
	print(randomint)
	if randomint == 2:
		largeCrateCollision.disabled = false
		crateCollision.disabled = true
		largeCrateCollision2.disabled = false
		crateCollision2.disabled = true
		sniperTexture.visible = true
		largeCrate.visible = true
		gunType = 2
	else:
		largeCrateCollision.disabled = true
		crateCollision.disabled = false
		largeCrateCollision2.disabled = true
		crateCollision2.disabled = false
		pistolTexture.visible = true
		crate.visible = true
		gunType = 1
	
func _physics_process(delta):
	if not is_on_floor():
		velocity.y = 200
	move_and_slide()


func _on_area_2d_area_entered(area):
	if area.is_in_group("player"):
		var grandparent = area.get_parent().get_parent()
		if grandparent and grandparent.has_method("collect_item"):
			grandparent.collect_item(gunType)
			queue_free()
	elif area.is_in_group("boundary"):
		global_script.crateNumber -= 1
		queue_free()

