extends TextureButton
class_name Slot

signal slot_selected
@export_category("Variables")
@onready var _container := $Container
@export var _sprite: Sprite2D
@export var _label: Label
@export var _can_drag: bool
@export var _selected: bool
@export var _initial_position: Vector2

func _ready() -> void:
	set_process(false)

func _update(_texture: CompressedTexture2D, _amount: int) -> void:
	_initial_position = _container.global_position
	_sprite.texture = _texture
	_sprite.hframes = 3
	_sprite.frame = 0
	_label.text = str(_amount)

func _process(_delta: float) -> void:
	_container.global_position = get_global_mouse_position()

func _on_pressed() -> void:
	slot_selected.emit()

func _on_button_down() -> void:
	_selected = true
	$DragCoolDownTimer.start()

func _on_button_up() -> void:
	_selected = false
	set_process(_selected)
	_container.global_position = _initial_position

func _on_drag_cool_down_timer_timeout() -> void:
	set_process(_selected)
