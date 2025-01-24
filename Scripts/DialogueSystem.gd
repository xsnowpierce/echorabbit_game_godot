extends Node

@export var dialogues: Array[Dialogue] = []
static var listeners : Array[Node]

func push_dialogue(dialogue : Dialogue) -> void:
	dialogues.append(dialogue)
	notify_new_dialogue()
	pass

func mark_dialogue_read(dialogue : Dialogue) -> void:
	dialogues.erase(dialogue)

func register_listener(node : Node) -> void:
	if(!listeners.has(node)):
		listeners.append(node)
		
func notify_new_dialogue() -> void:
	for n in listeners:
			n.notified_new_dialogue()
