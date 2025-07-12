extends Area2D


@export_category("Variables")
@export var _name: StringName
@export var _animation:AnimationPlayer
@export var _texture: Texture2D
@export var _range_position:int = 6
@export var _inventory : Resource = preload("res://scenes/inventory.tres")
var _can_collect:bool = false
var _speed:int = 50
var _velocity:Vector2 = Vector2.ZERO
var _global_position_body_entered:Vector2 = Vector2.ZERO
var _body_entered:bool = false

func _ready() -> void:
	$Spawn_light.visible = true
	$Spawn_light.play("spawn_light")
	await get_tree().create_timer(0.1).timeout
	$Spawn_light.visible = false
	_animation.play("spawn")
	$CollectTimer.start()


func _process(_delta: float) -> void:
	_can_collect = _inventory.verify_item_amount(_name)
	for _body in $PushArea.get_overlapping_bodies():
		if _body is Person and _can_collect:
			_velocity = _body.global_position - global_position
			_velocity.limit_length(1)

func _physics_process(_delta: float) -> void:
	if _can_collect:
		position += (_velocity.normalized() * _speed) * _delta

func _set_global_position(_position: Vector2) -> void:
	global_position = Vector2(
		_position.x + randi_range(_range_position * -1, _range_position),
		_position.y + randi_range(_range_position * -1, _range_position)
	)

func _on_body_entered(_body: Node2D) -> void:
	if _body is Person and _can_collect:
		var _item = {
			"name": _name,
			"texture": _texture
		}
		if _inventory.insert(_item):
			queue_free()

func _animation_finish(_anim_name: StringName) -> void:
	_animation.play("idle")


func _on_collect_timer_timeout() -> void:
	$Collision.disabled = false
	_can_collect = true
	$PushArea/PushCollision.disabled = false


func _on_push_area_body_entered(_body: Node2D) -> void:
	if _body is Person and _can_collect:
		set_process(true)
		set_physics_process(true)


func _on_push_area_body_exited(_body: Node2D) -> void:
	if _body is Person and _can_collect:
		_velocity = Vector2.ZERO
		set_process(false)
		set_physics_process(false)
