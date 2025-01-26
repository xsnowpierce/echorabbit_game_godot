extends Node

signal context_event(context : InteractContext.Context)

func push_context_event(context : InteractContext.Context) -> void:
	context_event.emit(context)
