extends CharacterBody2D

class_name PlayerMovement

enum MoveDirection
{
	UP, DOWN, LEFT, RIGHT
}

signal player_moved(velocity: Vector2)
signal player_ismoving(value : bool)
signal interact_pressed

@export var player_combat : PlayerCombat

@export var speed: int = 55
@export var attacking_slowdown : float = .5

func get_input() -> void:
	if(PauseGameSystem.pause_reasons > 0 or player_combat.is_attacking):
		velocity = Vector2(0, 0)
		player_ismoving.emit(false)
		return
	else:
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
	input_interact()

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

func input_interact() -> void:
	if(PauseGameSystem.has_pause_reason()):
		return
	if(Input.is_action_just_pressed("interact")):
		interact_pressed.emit()
