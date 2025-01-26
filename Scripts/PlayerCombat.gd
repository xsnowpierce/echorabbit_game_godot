extends Node2D

class_name PlayerCombat

@export var player_animator : PlayerAnimator
@export var player_movement : PlayerMovement

var carrot_scene = load("res://Scenes/carrot_projectile.tscn")

@export var button_hold_threshold : float = 0.5
var is_holding_attack_01 : bool = false
var is_holding_attack_02 : bool = false

var hold_time_attack01 : float = 0
var hold_time_attack02 : float = 0

var is_attacking : bool = false

@export var kick_length : float = .3

func _ready() -> void:
	PlayerInput.player_combat = self

func _process(delta: float) -> void:
	if(is_holding_attack_01):
		hold_time_attack01 += delta
	if(is_holding_attack_02):
		hold_time_attack02 += delta

func attack_01_pressed() -> void:
	if(PauseGameSystem.has_pause_reason()):
		return
		
	is_holding_attack_01 = true

func attack_02_pressed() -> void:
	if(PauseGameSystem.has_pause_reason()):
		return
		
	is_holding_attack_02 = true

func attack_01_released() -> void:
	if(!is_holding_attack_01):
		return
		
	is_holding_attack_01 = false
	if(PauseGameSystem.has_pause_reason()):
		return
	
	if(hold_time_attack01 < button_hold_threshold):
		attack_kick()
	else:
		attack_jump()
	
	hold_time_attack01 = 0
	
func attack_02_released() -> void:
	if(!is_holding_attack_02):
		return
		
	is_holding_attack_02 = false
	if(PauseGameSystem.has_pause_reason()):
		return
	
	if(hold_time_attack02 < button_hold_threshold):
		attack_throw()
	
	hold_time_attack02 = 0

func attack_jump() -> void:
	if(is_attacking):
		return
		
	print("jump")
	pass

func attack_kick() -> void:
	if(is_attacking):
		return
		
	is_attacking = true
	player_animator.set_sprite_kicking(true)
	var timer : float = 0
	while(timer < kick_length):
		timer += get_process_delta_time()
		await get_tree().process_frame
	player_animator.set_sprite_kicking(false)
	is_attacking = false

func attack_throw() -> void:
	if(is_attacking):
		return
		
	var carrot_object = carrot_scene.instantiate()
	get_tree().root.add_child(carrot_object)
	var carrot_spawn_position : Vector2 = global_position + get_carrot_spawn_position(get_throw_direction())
	var carrot_throw_direction : PlayerMovement.MoveDirection = get_throw_direction()
	
	carrot_object.position = carrot_spawn_position
	carrot_object.set_force(carrot_throw_direction)
	

func get_throw_direction() -> PlayerMovement.MoveDirection:
	return player_animator.last_move_direction
	
func get_carrot_spawn_position(direction : PlayerMovement.MoveDirection) -> Vector2:
	match direction:
		PlayerMovement.MoveDirection.UP:
			return Vector2(0, -16)
		PlayerMovement.MoveDirection.DOWN:
			return Vector2(0, 16)
		PlayerMovement.MoveDirection.LEFT:
			return Vector2(-16, 0)
		PlayerMovement.MoveDirection.RIGHT:
			return Vector2(16, 0)
	return Vector2(16, 0)
