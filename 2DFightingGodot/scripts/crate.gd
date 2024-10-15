extends CharacterBody2D

func _physics_process(delta):
	if not is_on_floor():
		velocity.y = 200
	move_and_slide()


func _on_area_2d_area_entered(area):
	if area.is_in_group("player"):
		var grandparent = area.get_parent().get_parent()
		if grandparent and grandparent.has_method("collect_item"):
			grandparent.collect_item(1)
			queue_free()
