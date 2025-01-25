extends TextureRect

var can_progress : bool = false
@export var flash_speed : float = 2

func _ready() -> void:
	end_flash()

func _on_text_can_progress_dialogue(value: bool) -> void:
		if(value == true and can_progress == false):
			flash_sprite()
		elif(value == false and can_progress == true):
			end_flash()

func flash_sprite() -> void:
	visible = true
	can_progress = true
	var timer : float = 0
	while(can_progress):
		timer += flash_speed * get_process_delta_time()
		if(timer >= 1.0):
			visible = !visible
			timer = 0
		await get_tree().process_frame

func end_flash() -> void:
	can_progress = false
	visible = false
