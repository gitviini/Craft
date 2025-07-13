extends Control
class_name Slot

@export var _inventory := preload("res://scenes/inventory.tres")
@onready var _box := $TextureButton/Box
@export var _sprite:Sprite2D
@export var _label:Label
@export var _index:int
@export var _is_empty:bool = true
@export var _selected:bool = false
@export var _initial_position: Vector2

func _ready() -> void:
	_inventory.inventory_update.connect(_update)
	_initial_position = global_position
	set_process(false)

func _process(_delta: float) -> void:
	if _inventory._slot_selected == _index and not _is_empty:
		_box.global_position = Vector2(
			get_global_mouse_position().x + 1,
			get_global_mouse_position().y + 1
			)
		return
	_box.global_position = _initial_position
	set_process(false)

func _update(_items: Array[Dictionary]) -> void:
	_initial_position = global_position
	var _item = _items.get(_index)
	if _item:
		_sprite.texture =  _item.texture
		_label.text = str(_item.amount)
		_is_empty = false
		return
	
	_sprite.texture = load("res://assets/images/sprites/inventory/empty.png")
	_label.text = ""
	_is_empty = true

func _on_texture_button_down() -> void:
	_selected = true
	if _inventory._slot_selected != -1 and _index != _inventory._slot_selected:
		_inventory._update(_index)
		_inventory._slot_selected = -1
	$SlotSelectedTimer.start()


func _on_texture_button_up() -> void:
	_selected = false

func _on_slot_selected_timer_timeout() -> void:
	if _selected and not _is_empty:
		_inventory._slot_selected = _index
		set_process(true)
