extends Control

var menu_is_open : bool = false

@export var button_scene = load("res://Scenes/action_menu_button.tscn")
@export var button_parent : Control
@export var buttons : Array[ActionMenuButton]

var selected_button : int = 0

func _ready() -> void:
	visible = false

func _process(delta: float) -> void:
	
	if(Input.is_action_just_pressed("menu")):
		toggle_menu()
		
	menu_movement()
	
	if(Input.is_action_just_pressed("menu_accept")):
		menu_accept()
	
	if(Input.is_action_just_pressed("menu_cancel")):
		menu_cancel()
	
func toggle_menu() -> void:
	if(menu_is_open):
		close_menu()
	else:
		open_menu()

func menu_movement() -> void:
	if(!menu_is_open):
		return
		
	if(Input.is_action_just_pressed("move_up")):
		select_button(selected_button - 1)
	if(Input.is_action_just_pressed("move_down")):
		select_button(selected_button + 1)

func menu_accept() -> void:
	if(menu_is_open):
		print("button ", str(selected_button), " pressed.")
		close_menu()

func menu_cancel() -> void:
	pass

func open_menu() -> void:
	create_buttons()
	menu_is_open = true
	PauseGameSystem.add_pause_reason()
	visible = true
	select_button(0)

func close_menu() -> void:
	destroy_buttons()
	menu_is_open = false
	PauseGameSystem.remove_pause_reason()
	visible = false
	selected_button = 0
	
func create_buttons() -> void:
	if(PlayerFlags.has_first_button):
		var created_button = button_scene.instantiate()
		button_parent.add_child(created_button)
		buttons.append(created_button)
	if(PlayerFlags.has_second_button):
		var created_button = button_scene.instantiate()
		button_parent.add_child(created_button)
		buttons.append(created_button)
	if(PlayerFlags.has_third_button):
		var created_button = button_scene.instantiate()
		button_parent.add_child(created_button)
		buttons.append(created_button)
	
func destroy_buttons() -> void:
	if(buttons.is_empty()):
		return
	for n in buttons:
		if(is_instance_valid(n)):
			n.free()
	buttons.clear()

func select_button(button_number : int) -> void:
	if(buttons.is_empty()):
		print("Tried to select buttons when list is null")
		return
	if(button_number >= buttons.size()):
		button_number = 0
	if(button_number < 0):
		button_number = buttons.size() - 1
	selected_button = button_number
	unselect_all_buttons()
	buttons[button_number].set_selected(true)
	
func unselect_all_buttons() -> void:
	if(buttons.is_empty()):
		return
	for n in buttons:
		if(n == null):
			continue
		n.set_selected(false)
