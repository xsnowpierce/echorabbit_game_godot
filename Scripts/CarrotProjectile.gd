extends Area2D

class_name CarrotProjectile

@export var carrot_speed : float = 80
@export var rotate : Node2D

var direction_vector : Vector2

func set_force(direction : PlayerMovement.MoveDirection) -> void:
	direction_vector = Vector2(0,0)
	match direction:
		PlayerMovement.MoveDirection.UP:
			direction_vector = Vector2(0, -1) * carrot_speed
			rotate.rotation_degrees = -180
		PlayerMovement.MoveDirection.DOWN:
			direction_vector = Vector2(0, 1) * carrot_speed
			rotate.rotation_degrees = 0
		PlayerMovement.MoveDirection.LEFT:
			direction_vector = Vector2(-1, 0) * carrot_speed
			rotate.rotation_degrees = 90
		PlayerMovement.MoveDirection.RIGHT:
			direction_vector = Vector2(1, 0) * carrot_speed
			rotate.rotation_degrees = -90

func _process(delta: float) -> void:
	position += (direction_vector * get_process_delta_time())

func on_collision_entered(collider : Node2D) -> void:
	if(collider.is_in_group("Player")):
		return
	direction_vector = Vector2(0, 0)
	queue_free()
