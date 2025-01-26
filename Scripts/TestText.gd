extends "Interactable.gd"

@export var text : Dialogue

signal has_interacted(interact_info : InteractInfo)

func interact(interact_info : InteractInfo) -> void:
	has_interacted.emit(interact_info)
	DialogueSystem.push_dialogue(text)

func context_interact(interact_info : InteractInfo, interact_context : InteractContext.Context) -> void:
	has_interacted.emit(interact_info)
	match(interact_context):
		InteractContext.Context.SPIT:
			var dialogue : Dialogue = Dialogue.new()
			dialogue.conversation = ["Why u spit on me..."]
			DialogueSystem.push_dialogue(dialogue)
		InteractContext.Context.PUNCH:
			var dialogue : Dialogue = Dialogue.new()
			dialogue.conversation = ["OWCH!!!"]
			DialogueSystem.push_dialogue(dialogue)
		InteractContext.Context.SNIFF:
			var dialogue : Dialogue = Dialogue.new()
			dialogue.conversation = ["Do I smell good?"]
			DialogueSystem.push_dialogue(dialogue)
