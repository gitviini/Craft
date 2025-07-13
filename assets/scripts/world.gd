extends Node

@export var _inventory := preload("res://scenes/inventory.tres")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_game()

func _key_bindings() -> void:
	if Input.is_action_just_pressed("reload"):
		await get_tree().create_timer(0.2).timeout
		var _reload = get_tree().reload_current_scene()
		_inventory._items = []

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	_key_bindings()


func start_game() -> void:
	$Container/Player.start_position($StartPosition.position)
