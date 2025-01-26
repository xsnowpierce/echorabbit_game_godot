extends Node2D

class_name PlayerInteract

var last_move_direction : Vector2
var interact_array : Array[Node2D]

func _ready() -> void:
	PlayerInput.player_interact = self
	EventSystem.context_event.connect(context_interact_pushed.bind())

func _on_interact_entered(body: Node2D) -> void:
	if(body.is_in_group("Interactable") and body.has_method("interact")):
		interact_array.append(body)
		
func _on_interact_exited(body: Node2D) -> void:
	interact_array.erase(body)
	
func interact() -> void:
	if(interact_array.size() > 0):
		if(interact_array[0].has_method("interact")):
			var interact_info : InteractInfo = InteractInfo.new()
			interact_info.set_info(self)
			interact_array[0].interact(interact_info)

func context_interact_pushed(context : InteractContext.Context) -> void:
	if(interact_array.size() > 0):
		if(interact_array[0].has_method("context_interact")):
			var interact_info : InteractInfo = InteractInfo.new()
			interact_info.set_info(self)
			interact_array[0].context_interact(interact_info, context)
	else:
		var dialogue : Dialogue = Dialogue.new()
		dialogue.conversation = ["Nothing happened..."]
		DialogueSystem.push_dialogue(dialogue)
