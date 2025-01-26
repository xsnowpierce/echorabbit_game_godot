extends TextureRect

class_name ActionMenuButton

@export var selected_texture : Texture2D
@export var deselected_texture : Texture2D

var is_selected : bool = false

func _ready() -> void:
	set_selected(false)

func set_selected(value : bool) -> void:
	is_selected = value
	if(value):
		texture = selected_texture
	else:
		texture = deselected_texture
	
func set_button_text(value : String) -> void:
	get_node("Label").text = value
