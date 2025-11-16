class_name PlayerStateJump extends PlayerState


@export var jump_velocity : float = 450


func enter() -> void:
	player.add_debug_indicator( Color.LIME_GREEN )
	player.velocity.y = -jump_velocity
	if not Input.is_action_pressed( "jump" ):
		player.velocity.y *= 0.5


func exit() -> void:
	pass


func handle_input( event: InputEvent ) -> PlayerState:
	if event.is_action_released( "jump" ):
		player.velocity.y *= 0.5
	return next_state


func process( _delta: float ) -> PlayerState:
	return next_state


func physics_process( _delta: float ) -> PlayerState:
	if player.is_on_floor():
		return idle
	if player.velocity.y >= 0:
		return fall
	player.velocity.x = player.direction.x * player.move_speed
	return next_state 
