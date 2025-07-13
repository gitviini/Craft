extends Area2D
class_name Item

@export_category("Variables")
@export var _inventory := preload("res://scenes/inventory.tres")
@export var _name: StringName
@export var _animation:AnimationPlayer
@export var _texture: Texture2D
@export var _range_position:int = 6
var _can_collect:bool = false

func _ready() -> void:
	$Spawn_light.visible = true
	$Spawn_light.play("spawn_light")
	await get_tree().create_timer(0.1).timeout
	$Spawn_light.visible = false
	_animation.play("spawn")
	$CollectTimer.start()

func _set_global_position(_position: Vector2) -> void:
	global_position = Vector2(
		_position.x + randi_range(_range_position * -1, _range_position),
		_position.y + randi_range(_range_position * -1, _range_position)
	)

func _on_body_entered(_body: Node2D) -> void:
	if _body is Person and _can_collect:
		var _item = {
			"name": _name,
			"texture": _texture,
			"amount": 1
		}
		_inventory._insert(_item)
		queue_free()

func _animation_finish(_anim_name: StringName) -> void:
	_animation.play("idle")


func _on_collect_timer_timeout() -> void:
	$Collision.disabled = false
	_can_collect = true
