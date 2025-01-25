extends Node

@export var inventory_dictionary = {}

func _ready() -> void:
	pass
	
func add_item(item : InvItem, amount : int) -> void:
	inventory_dictionary[item] = amount
	var dialogue : Dialogue = Dialogue.new()
	var line : String = "You picked up " + str(amount) + " " + item.name + "."
	dialogue.conversation.append(line)
	DialogueSystem.push_dialogue(dialogue)
	pass
	
func remove_item(item : InvItem, amount : int) -> void:
	if(inventory_dictionary[item] - amount <= 0):
		inventory_dictionary.erase(item)
	else:
		inventory_dictionary[item] = inventory_dictionary[item] - amount

func has_item(item : InvItem, amount : int) -> bool:
	if(inventory_dictionary.has(item)):
		return true
	return false

func get_item_amount(item : InvItem) -> int:
	if(inventory_dictionary.has(item)):
		return inventory_dictionary[item]
	else:
		return 0
