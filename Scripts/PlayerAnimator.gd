extends AnimatedSprite2D

class_name PlayerAnimator

var is_moving : bool = false
var last_move_direction : PlayerMovement.MoveDirection
var is_kicking : bool = false

func _physics_process(_delta: float) -> void:
	if(is_playing() and is_moving == false):
		pause()
		frame = 0
	elif(is_playing() == false and is_moving):
		play()

func _on_player_player_moved(input_direction: Vector2) -> void:
	
	if(is_kicking):
		return
	
	var dir : PlayerMovement.MoveDirection
	
	if(input_direction.x > 0):
		dir = PlayerMovement.MoveDirection.RIGHT
	elif(input_direction.x < 0):
		dir = PlayerMovement.MoveDirection.LEFT
	elif(input_direction.y > 0):
		dir = PlayerMovement.MoveDirection.DOWN
	elif(input_direction.y < 0):
		dir = PlayerMovement.MoveDirection.UP
	
	last_move_direction = dir
	animate_direction(dir)

func animate_direction(direction : PlayerMovement.MoveDirection):
	match direction:
		PlayerMovement.MoveDirection.UP:
			play("up")
		PlayerMovement.MoveDirection.DOWN:
			play("down")
		PlayerMovement.MoveDirection.LEFT:
			play("left")
		PlayerMovement.MoveDirection.RIGHT:
			play("right")

func animate_kick_direction(direction : PlayerMovement.MoveDirection):
	match direction:
		PlayerMovement.MoveDirection.UP:
			position = Vector2(0, -16)
			play("kick_up")
		PlayerMovement.MoveDirection.DOWN:
			play("kick_down")
		PlayerMovement.MoveDirection.LEFT:
			position = Vector2(-16, 0)
			play("kick_left")
		PlayerMovement.MoveDirection.RIGHT:
			play("kick_right")

func _on_player_player_ismoving(value: bool) -> void:
	is_moving = value
	
func set_sprite_kicking(value: bool) -> void:
	is_kicking = value
	if(value):
		animate_kick_direction(last_move_direction)
	else: 
		animate_direction(last_move_direction)
		position = Vector2(0, 0)
	
