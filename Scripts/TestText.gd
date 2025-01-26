extends "Interactable.gd"

@export var text : Dialogue

signal text_box_event(text : Dialogue)

func interact() -> void:
	DialogueSystem.push_dialogue(text)

func context_interact(interact_context : InteractContext.Context) -> void:
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
