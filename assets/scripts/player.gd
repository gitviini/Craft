extends CharacterBody2D
class_name CharacterBody

@export_category("Variables")
@export var SPEED:int = 50
@export var _direction:Vector2 = Vector2.ZERO
@export var _flip_h:bool = false
@export var _damage:int = 10
var _animation:StringName
var _screen_size:Vector2
var _run_action:bool = false


func _ready() -> void:
	_animation = "idle_down"
	_screen_size = get_viewport().size

func set_animation() -> void:
	_animation = _animation if velocity.y == 0 else ("walk_down" if velocity.y > 0 else "walk_up")
	_animation = _animation if velocity.x == 0 else "walk_right"
	if velocity.length() == 0:
		_animation = _animation.replace("walk","idle")
	$Sprite.flip_h = _flip_h
	$ActionArea.rotation =  $ActionArea.rotation if _direction.y == 0 else (deg_to_rad(180) if _direction.y < 0 else deg_to_rad(0))
	$ActionArea.rotation =  $ActionArea.rotation if _direction.x == 0 else deg_to_rad(90) * _direction.x * -1
	$AnimationPlayer.play(_animation)

func _process(delta: float) -> void:
	set_animation()

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("ui_accept") and not _run_action:
		set_physics_process(false)
		set_process(false)
		_animation = _animation.replace("idle" if _animation.count("idle") else "walk", "action") 
		$Hand.flip_h = _flip_h
		$Hand.position.x = -8 if _flip_h else 8
		$AnimationPlayer.play(_animation)
		_run_action = true
		return
		
	_direction = Vector2.ZERO
	_direction.x = Input.get_axis("ui_left", "ui_right")
	_direction.y = Input.get_axis("ui_up", "ui_down")
	_flip_h = true if _direction.x == -1 else _flip_h
	_flip_h = false if _direction.x == 1 else _flip_h
	if _direction.length() > 0:
		velocity = SPEED * _direction.normalized()
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()

func start_position(_position) -> void:
	position = _position


func _on_action_area_body_entered(_body: Node2D) -> void:
	if _body is PhysicObject:
		_body.hit(_damage)


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	if _anim_name.count("action"):
		$CoolDown.start()
		_animation = _animation.replace("action","idle")
		set_process(true)
		set_physics_process(true)


func _on_cool_down_timeout() -> void:
	_run_action = false
