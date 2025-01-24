extends Control

signal dialogue_displayed(dialogue : Dialogue)

@export var text_opened : bool = false

func _ready() -> void:
	DialogueSystem.register_listener(self)
	pass

func display_dialogue(dialogue : Dialogue):
	text_opened = true
	show_text_box(true)
	dialogue_displayed.emit(dialogue)

func _on_rich_text_label_text_complete() -> void:
	text_opened = false
	show_text_box(false)

func show_text_box(value : bool) -> void:
	visible = value

func _on_area_2d_text_box_event(dialogue : Dialogue) -> void:
	display_dialogue(dialogue)
	
func notified_new_dialogue() -> void:
	for n in DialogueSystem.dialogues:
		display_dialogue(n)
