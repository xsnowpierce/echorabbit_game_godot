extends CharacterBody2D

signal player_moved(velocity: Vector2)
signal player_ismoving(value : bool)
@export var speed: int = 55

func get_input() -> void:
	var input_direction : Vector2 = get_movement_amount()
	velocity = input_direction * speed
	if(input_direction.length() > 0):
		player_moved.emit(input_direction)
		player_ismoving.emit(true)
	else: 
		player_ismoving.emit(false)

func _process(_delta : float) -> void:
	get_input()
	move_and_slide()

func get_movement_amount() -> Vector2:
	var movement : Vector2
	if(Input.is_action_pressed("move_right")):
		movement.x += 1
	if(Input.is_action_pressed("move_left")):
		movement.x -= 1
	if(Input.is_action_pressed("move_down")):
		movement.y += 1
	if(Input.is_action_pressed("move_up")):
		movement.y -= 1
	return movement
