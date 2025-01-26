extends Resource

class_name InteractInfo

var _interacted_node : Node2D

func set_info(interacted_node : Node2D) -> void:
	_interacted_node = interacted_node

func get_info() -> void:
	if(_interacted_node == null):
		print("Tried to get interact info when info was null.")

func get_interacted_node() -> Node2D:
	return _interacted_node
