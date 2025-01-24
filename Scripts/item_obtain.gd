extends StaticBody2D

@export var held_item : InvItem
@export var held_item_amount : int = 1
signal give_item(item : InvItem, item_amount : int)

func interact():
	give_item.emit(held_item, held_item_amount)
	PlayerInventory.add_item(held_item, held_item_amount)
	destroy_self()
	
func destroy_self():
	queue_free()
