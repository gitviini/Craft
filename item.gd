extends Area2D

@export_category("Variables")
@export var _animation: AnimationPlayer
@export var _range_position: int = 6
var _can_collect = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_animation.play("spawn")
	$CollectTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _set_global_position(_position: Vector2) -> void:
	global_position = Vector2(
		_position.x + randi_range(_range_position * -1, _range_position),
		_position.y + randi_range(_range_position * -1, _range_position)
	)

func _on_body_entered(_body: Node2D) -> void:
	if _body is CharacterBody and _can_collect:
		queue_free()

func _animation_finish(_anim_name: StringName) -> void:
	_animation.play("idle")


func _on_collect_timer_timeout() -> void:
	$CollisionShape2D.disabled = false
	_can_collect = true
