extends Resource
class_name inventory

signal inventory_update

@export var _items := {}
@export var _max_inventory_length := 5
@export var _max_item_amount := 5
@export var _hot_bar := {}
@export var _max_hot_bar_length := 3

func verify_item_amount(_item_name: StringName) -> bool:
	return _items.get(_item_name, {}).get("amount", 0) < _max_item_amount

func insert(_item: Dictionary) -> bool:
	if len(_items.keys()) > _max_inventory_length: 
		return false
	
	var _amount = _items.get(_item.name, {}).get("amount", 0)
	
	if not verify_item_amount(_item.name):
		return false
	
	_items[_item.name] = {
		"name": _item.name,
		"texture": _item.texture,
		"amount": _amount + 1
	}
	
	update()
	return true
	
func update() -> void:
	#print(_items)
	for _item in _items:
		pass
	inventory_update.emit()
