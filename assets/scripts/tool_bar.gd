extends GridContainer
class_name ToolBar

@export var _inventory := preload("res://scenes/inventory.tres")
@export var _slot_scene := preload("res://scenes/slot.tscn")
@export var _cell_size_x := 24

func _ready() -> void:
	columns = _inventory._amount_tool_bar_slot
	size.x = _cell_size_x * _inventory._amount_tool_bar_slot
	position.x -= size.x / 2
	for _i in range(_inventory._amount_tool_bar_slot):
		var _slot = _slot_scene.instantiate()
		_slot._index = _i
		add_child(_slot)
		_inventory._items.append({})
