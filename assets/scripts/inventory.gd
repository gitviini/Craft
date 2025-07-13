extends Resource
class_name Inventory

signal inventory_update
@export var _items: Array[Dictionary]

func _insert(_new_item) -> void:
	var _search_item
	for _item in _items:
		if _item.get("name") == _new_item.get("name"):
			_search_item = _item
			break
	
	if _search_item:
		_search_item.amount += _new_item.amount
	else:
		_items.append(
			{
				"name": _new_item.name,
				"texture": _new_item.texture,
				"amount": _new_item.amount
			}
		)

	print("entrou")
	inventory_update.emit(_items)
