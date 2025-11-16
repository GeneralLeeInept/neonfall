class_name Player extends CharacterBody2D

@export var player_speed: int = 100

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	velocity.x = 0
	if Input.is_action_pressed("left"):
		velocity.x -= player_speed
	if Input.is_action_pressed("right"):
		velocity.x += player_speed

	move_and_slide()
