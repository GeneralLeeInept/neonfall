class_name PlayerStateFall extends PlayerState

func init() -> void:
	pass


func enter() -> void:
	pass


func exit() -> void:
	player.add_debug_indicator( Color.RED )


func handle_input( event: InputEvent ) -> PlayerState:
	return next_state


func process( delta: float ) -> PlayerState:
	if player.is_on_floor():
		return idle
	return next_state


func physics_process(delta: float) -> PlayerState:
	player.velocity.x = player.direction.x * player.move_speed
	return next_state
