extends Control
class_name Slot


@export var _inventory := preload("res://scenes/inventory.tres")
@export var _sprite:Sprite2D
@export var _label:Label
@export var _index:int

func _ready() -> void:
	_inventory.inventory_update.connect(_update)

func _update(_items: Array[Dictionary]):
	var _item = _items.get(_index)
	
	if _item:
		_sprite.texture =  _item.texture
		_label.text = str(_item.amount)
		return
	
	_sprite.texture = load("res://assets/images/sprites/inventory/empty.png")
	_label.text = ""
