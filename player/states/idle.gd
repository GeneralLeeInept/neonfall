class_name PlayerStateIdle extends PlayerState


func handle_input( event: InputEvent ) -> PlayerState:
	if event.is_action_pressed( "jump" ):
		return jump
	return next_state


func process( _delta: float ) -> PlayerState:
	if player.direction.x != 0:
		return run
	if player.direction.y > 0.5:
		return crouch
	return next_state


func physics_process( _delta: float ) -> PlayerState:
	if absf(player.velocity.x) > 1:
		player.velocity.x *= player.friction
	else:
		player.velocity.x = 0
	if not player.is_on_floor():
		return fall
	return next_state
