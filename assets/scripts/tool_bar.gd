extends CanvasLayer
class_name ToolBar

@export var _container:GridContainer
@export var _slot_scene := preload("res://scenes/slot.tscn")
@export var _amount_slots := 4
@export var _cell_size_x := 24

func _ready() -> void:
	_container.columns = _amount_slots
	_container.size.x = _cell_size_x * _amount_slots
	_container.position.x -= _container.size.x / 2
	for _i in range(_amount_slots):
		var _slot = _slot_scene.instantiate()
		_slot._index = _i
		_container.add_child(_slot)
