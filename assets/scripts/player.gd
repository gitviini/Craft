extends CharacterBody2D

const SPEED = 75
var direction = Vector2.ZERO
var flip_h = false
var animation
var screen_size

func _ready() -> void:
	animation = Array($AnimatedSprite2D.sprite_frames.get_animation_names())[0]
	screen_size = get_viewport().size

func set_animation() -> void:
	animation = animation if velocity.y == 0 else ("walk_down" if velocity.y > 0 else "walk_up")
	animation = animation if velocity.x == 0 else "walk_right"
	if velocity.length() == 0:
		animation = animation.replace("walk","idle")
	$AnimatedSprite2D.flip_h = flip_h
	$AnimatedSprite2D.play(animation)

func _process(delta: float) -> void:
	set_animation()

func _physics_process(delta: float) -> void:
	direction = Vector2.ZERO
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	flip_h = true if direction.x == -1 else flip_h
	flip_h = false if direction.x == 1 else flip_h
	if direction:
		velocity = SPEED * direction.normalized()
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()

func start_position(_position) -> void:
	position = _position
