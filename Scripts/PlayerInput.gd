extends Node

signal input_interact(hold_time : float)
signal input_attack1(hold_time : float)
signal input_attack2(hold_time : float)
var player_interact : PlayerInteract
var player_combat : PlayerCombat

func _process(delta: float) -> void:
	
	if(PauseGameSystem.has_pause_reason()):
		return
		
	if(player_interact == null):
		return
		
	if(Input.is_action_just_pressed("attack_01")):
		holding_input1()
		
	if(Input.is_action_just_pressed("attack_02")):
		holding_input2()
	
	if(Input.is_action_just_released("attack_01")):
		released_input1()
	
	if(Input.is_action_just_released("attack_02")):
		released_input2()

func holding_input1() -> void:
	if(player_interact.interact_array.size() > 0):
		player_interact.interact()
	else:
		player_combat.attack_01_pressed()
	
func holding_input2() -> void:
	player_combat.attack_02_pressed()

func released_input1() -> void:
	player_combat.attack_01_released()
	pass

func released_input2() -> void:
	player_combat.attack_02_released()
	pass
