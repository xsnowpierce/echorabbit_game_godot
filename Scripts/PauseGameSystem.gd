extends Node

static var pause_reasons : int = 0

func add_pause_reason() -> void:
	pause_reasons += 1

func remove_pause_reason() -> void:
	pause_reasons -= 1
	if(pause_reasons < 0):
		pause_reasons = 0

func has_pause_reason() -> bool:
	return pause_reasons > 0
