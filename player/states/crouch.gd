class_name PlayerStateCrouch extends PlayerState


func enter() -> void:
	player.sprite_2d.scale.y = 0.625
	player.sprite_2d.position.y = -15.0
	player.collision_crouching.disabled = false
	player.collision_standing.disabled = true
	print("player.velocity = ", player.velocity)
	player.add_debug_indicator(Color.BLUE_VIOLET)


func exit() -> void:
	player.sprite_2d.scale.y = 1
	player.sprite_2d.position.y = -24.0
	player.collision_crouching.disabled = true
	player.collision_standing.disabled = false


func handle_input( event: InputEvent ) -> PlayerState:
	if event.is_action_pressed( "jump" ):
		if player.one_way_platform_shape_cast.is_colliding():
			player.position.y += 4
			return fall
		else:
			return jump
	return next_state


func process( _delta: float ) -> PlayerState:
	if player.direction.y < 0.3:
		return idle
	return next_state


func physics_process( _delta: float ) -> PlayerState:
	if absf(player.velocity.x) > 1:
		player.velocity.x *= player.friction
	else:
		player.velocity.x = 0
	if not player.is_on_floor():
		return fall
	return next_state
