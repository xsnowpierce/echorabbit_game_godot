extends RichTextLabel

@export var text_display_speed : float = .05
var text_is_complete : bool = false
var player_has_input : bool = false
var current_dialogues : Array[Dialogue]

signal text_complete
signal can_progress_dialogue(value : bool)

func _on_text_box_dialogue_displayed(dialogue: Dialogue) -> void:
	
	current_dialogues.append(dialogue)
	
	## add a pause reason so we can wait for player input to continue
	PauseGameSystem.add_pause_reason()
	
	## reset text
	text = ""
	for dialogue_piece in current_dialogues:
		
		for message in dialogue_piece.conversation:
		
			## reset all values that will change in this function
			player_has_input = false
			visible_characters_behavior = 1
			visible_characters = 0
			text = message
			can_progress_dialogue.emit(false)
		
			## loop over all characters in the message and make them visible
			var characters : int = message.length()
			for n in characters:
				visible_characters = n
				var current_timer : float = 0
				while current_timer < text_display_speed:
					current_timer += get_process_delta_time()
					await get_tree().process_frame
				
			## message has finished printing, set all to visible to be safe
			visible_characters = -1
		
			## wait for player input to continue
			while player_has_input == false:
				can_progress_dialogue.emit(true)
				if(Input.is_action_just_pressed("interact")):
					player_has_input = true
				await get_tree().process_frame
			
			## possible error here: it might skip dialogues since we're removing whilst iterating
			current_dialogues.erase(dialogue_piece)
	
	## finished, notifiy everything that we're done printing text
	text_is_complete = true
	text_complete.emit()
	DialogueSystem.mark_dialogue_read(dialogue)
	visible_characters_behavior = 0
	PauseGameSystem.remove_pause_reason()
