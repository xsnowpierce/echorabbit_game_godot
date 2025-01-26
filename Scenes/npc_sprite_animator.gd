extends AnimatedSprite2D

enum InteractDirection {UP, DOWN, LEFT, RIGHT}

func _on_area_2d_has_interacted(interact_info: InteractInfo) -> void:
	animate_direction(get_interact_direction(interact_info))
	
func get_interact_direction(interact_info : InteractInfo) -> InteractDirection:
	var current_position : Vector2 = global_position
	var interact_position : Vector2 = interact_info.get_interacted_node().global_position
	
	var normalized_difference : Vector2 = (current_position - interact_position).normalized()
	
	print(current_position, ", ", interact_position, ", ", normalized_difference)
	
	if(abs(normalized_difference.x) > abs(normalized_difference.y)):
		if(normalized_difference.x < 0):
			return InteractDirection.RIGHT
		if(normalized_difference.x > 0):
			return InteractDirection.LEFT
	elif(abs(normalized_difference.y) > abs(normalized_difference.x)):
		if(normalized_difference.y < 0):
			return InteractDirection.DOWN
		if(normalized_difference.y > 0):
			return InteractDirection.UP
	
	return InteractDirection.DOWN

func animate_direction(direction : InteractDirection):
	match direction:
		InteractDirection.UP:
			play("up")
		InteractDirection.DOWN:
			play("down")
		InteractDirection.LEFT:
			play("left")
		InteractDirection.RIGHT:
			play("right")
