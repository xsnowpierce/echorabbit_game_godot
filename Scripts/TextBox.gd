extends Control

signal text_displayed(text)

@export var text_opened : bool = false

func display_text(text : String):
	text_opened = true
	show_text_box(true)
	text_displayed.emit(text)


func _on_rich_text_label_text_complete() -> void:
	text_opened = false
	show_text_box(false)

func show_text_box(value : bool) -> void:
	visible = value


func _on_area_2d_text_box_event(text: String) -> void:
	display_text(text)
