extends StaticBody2D
class_name PhysicObject

@export_category("Variables")
@export var _animation: AnimationPlayer
@export var _droppable: Array[PackedScene]
@export var _idle_animation: Dictionary
@export var _hit_animation: Dictionary
@export var _max_health:int = 30
@export var _min_health:int = 20
@export var _health:int = randi_range(_min_health, _max_health)
@export var _max_drop: int = 2
@export var _min_drop: int = 1

func _get_animation(_dict_animation) -> StringName:
	var _name:StringName
	
	for _key in _dict_animation:
		var _min_health_animation = _key
		var _anim_name = _dict_animation.get(_key)
		
		if _health >= _min_health_animation:
			_name = _anim_name
			
	return _name

func _ready() -> void:
	pass

func hit(_damage:int) -> void:
	if _health > 0:
		_animation.play(_get_animation(_hit_animation))
		_health -= _damage
		set_process(false)

func _process(_delta: float) -> void:
	if _health <= 0:
		for _drop_item in _droppable:
			for _i in range(randi_range(_min_drop, _max_drop)):
				var _drop = _drop_item.instantiate()
				_drop._set_global_position(global_position)
				get_parent().add_child(_drop)
		queue_free()
		return

func _animation_finished(_anim_name:StringName) -> void:
	if _anim_name.contains("hit"):
		set_process(true)
		_animation.play(_get_animation(_idle_animation))
