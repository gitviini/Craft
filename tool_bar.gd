extends CanvasLayer

@export_category("Variables")
@export var _inventory := preload("res://scenes/inventory.tres")
@export var _slot_scene := preload("res://scenes/slot.tscn")
@export var _hot_bar_slots: Array[Slot]
@onready var _container_hot_bar_slots := $ContainerToolBar/Control

func _ready() -> void:
	_inventory.inventory_update.connect(_update)
	_set_slots()

func _set_slots() -> void:
	_container_hot_bar_slots.columns = _inventory._max_hot_bar_length
	for _i in _inventory._max_hot_bar_length:
		var _slot = _slot_scene.instantiate()
		_container_hot_bar_slots.add_child(_slot)
		_hot_bar_slots.append(_slot)

func _update() -> void:
	for _i in range(len(_inventory._items.keys())):
		var _slot = _hot_bar_slots.get(_i)
		if not _slot: return
		var _tool_name = _inventory._items.keys().get(_i)
		var _texture = _inventory._items[_tool_name].get("texture")
		var _amount = _inventory._items[_tool_name].get("amount")
		print(_tool_name)
		_slot._update(_texture, _amount)
		
	#for i in range(len(_inventory._items.keys())):
		#var _name = _inventory._items.keys()[i]
		#var _tool = _tools[i]a
		#var _texture = _inventory._items[_name].get("texture")
		#var _amount = _inventory._items[_name].get("amount")
		#
		#var _tool_sprite = _tool.get_child(0)
		#var _tool_amount = _tool.get_child(1)
		#_tool_sprite.texture = _texture
		#_tool_sprite.hframes = 3
		#_tool_sprite.frame = 0
		#_tool_amount.text = str(_amount)

func _clear() -> void:
	#for _tool in _tools:
		#var _sprite = _tool.get_child(0)
		#var _amount = _tool.get_child(1)
		#_sprite.texture = Texture2D.new()
		#_amount.text = ""
	pass
