class_name PlayerStateRun extends PlayerState


func handle_input( event: InputEvent ) -> PlayerState:
	if event.is_action_pressed( "jump" ):
		return jump
	return next_state


func process( _delta: float ) -> PlayerState:
	if player.direction.x == 0:
		return idle
	if player.direction.y > 0.5:
		return crouch
	return next_state


func physics_process( _delta: float ) -> PlayerState:
	player.velocity.x = player.direction.x * player.move_speed
	if not player.is_on_floor():
		return fall
	return next_state
