extends Resource
class_name Inventory

signal inventory_update
@export var _items: Array[Dictionary]
@export var _slot_selected: int = -1
@export var _amount_tool_bar_slot := 3
@export var _amount_intentory_grid_slot := 10

func _insert(_new_item) -> void:
	var _search_item
	for _item in _items:
		if _item.get("name") == _new_item.get("name"):
			_search_item = _item
			break
	
	if _search_item:
		_search_item.amount += _new_item.amount
	else:
		var _new_item_index = _items.find({})
		_items.insert(
			_new_item_index,
			{
				"name": _new_item.name,
				"texture": _new_item.texture,
				"amount": _new_item.amount
			}
		)
	inventory_update.emit(_items)

func _update(_slot_index) -> void:
	var _old_content = _items.get(_slot_index)
	var _new_content = _items.get(_slot_selected)
	_items[_slot_index] = _new_content
	_items[_slot_selected] = _old_content
	
	inventory_update.emit(_items)
