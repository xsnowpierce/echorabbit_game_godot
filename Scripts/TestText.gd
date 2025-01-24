extends "Interactable.gd"

@export var text : Dialogue

signal text_box_event(text : Dialogue)


func interact() -> void:
	DialogueSystem.push_dialogue(text)
