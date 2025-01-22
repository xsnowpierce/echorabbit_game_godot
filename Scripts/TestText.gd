extends Node2D

@export var text : String

signal text_box_event(text : String)


func _on_body_entered(body: Node2D) -> void:
	text_box_event.emit(text)
