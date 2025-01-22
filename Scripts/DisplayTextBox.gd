extends RichTextLabel

@export var text_display_speed : float = .05
var text_is_complete : bool = false;

signal text_complete

func _on_text_box_text_displayed(text: String) -> void:
	clear()
	var characters : int = text.length()
	for n in characters:
		append_text(text[n])
		var current_timer : float = 0
		while current_timer < text_display_speed:
			current_timer += get_process_delta_time()
			await get_tree().process_frame
	text_is_complete = true
	text_complete.emit()
