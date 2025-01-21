extends AnimatedSprite2D

enum MoveDirection
{
	UP, DOWN, LEFT, RIGHT
}

var is_moving : bool = false

func _physics_process(delta: float) -> void:
	if(is_playing() and is_moving == false):
		pause()
		frame = 0
	elif(is_playing() == false and is_moving):
		play()

func _on_player_player_moved(input_direction: Vector2) -> void:
	var dir : MoveDirection
	
	if(input_direction.x > 0):
		dir = MoveDirection.RIGHT
	elif(input_direction.x < 0):
		dir = MoveDirection.LEFT
	elif(input_direction.y > 0):
		dir = MoveDirection.DOWN
	elif(input_direction.y < 0):
		dir = MoveDirection.UP
	
	animate_direction(dir)

func animate_direction(direction : MoveDirection):
	match direction:
		MoveDirection.UP:
			play("up")
		MoveDirection.DOWN:
			play("down")
		MoveDirection.LEFT:
			play("left")
		MoveDirection.RIGHT:
			play("right")
	
func _on_player_player_ismoving(value: bool) -> void:
	is_moving = value
