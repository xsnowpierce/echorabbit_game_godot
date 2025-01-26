extends Node

var last_move_direction : Vector2
var interact_array : Array[Node2D]

func _ready() -> void:
	EventSystem.context_event.connect(context_interact_pushed.bind())

func _on_interact_entered(body: Node2D) -> void:
	if(body.is_in_group("Interactable") and body.has_method("interact")):
		interact_array.append(body)
		
func _on_interact_exited(body: Node2D) -> void:
	interact_array.erase(body)
	
func interact() -> void:
	if(interact_array.size() > 0):
		if(interact_array[0].has_method("interact")):
			interact_array[0].interact()

func context_interact_pushed(context : InteractContext.Context) -> void:
	if(interact_array.size() > 0):
		if(interact_array[0].has_method("context_interact")):
			interact_array[0].context_interact(context)
