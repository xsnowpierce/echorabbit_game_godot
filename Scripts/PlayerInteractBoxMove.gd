extends CollisionShape2D

var top_position : Vector2 = Vector2(8, -6)
var bottom_position : Vector2 = Vector2(8, 22)
var left_position : Vector2 = Vector2(-6, 8)
var right_position : Vector2 = Vector2(22, 8)

func _on_rigid_body_2d_player_moved(velocity: Vector2) -> void:
	move_box_to_direction(velocity)

func move_box_to_direction(direction : Vector2) -> void:
	if(direction.x > 0):
		position = right_position
	elif(direction.x < 0):
		position = left_position
	elif(direction.y > 0):
		position = bottom_position
	elif(direction.y < 0):
		position = top_position
