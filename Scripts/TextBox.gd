extends Control

signal text_displayed(text)

var processed : bool = false
@export var text_opened : bool = false

func _process(delta: float) -> void:
	if processed == false:
		display_text("jfgiudkgjfdgjklhlfdf")
	processed = true

func display_text(text : String):
	text_opened = true
	show_text_box(true)
	text_displayed.emit(text)


func _on_rich_text_label_text_complete() -> void:
	text_opened = false
	show_text_box(false)

func show_text_box(value : bool) -> void:
	visible = value
