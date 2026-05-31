extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

const IDLE_ANIMATION := &"idle"
const RUN_ANIMATION := &"run"
const JUMP_ANIMATION := &"jump"

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D



func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func update_animation() -> void:
	if not is_on_floor():
		animated_sprite.play(JUMP_ANIMATION)
	elif absf(velocity.x) > 0.0:
		animated_sprite.play(RUN_ANIMATION)
	else:
		animated_sprite.play(IDLE_ANIMATION)
