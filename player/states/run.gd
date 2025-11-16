class_name PlayerStateRun extends PlayerState


func init() -> void:
	pass


func enter() -> void:
	pass


func exit() -> void:
	pass


func handle_input( event: InputEvent ) -> PlayerState:
	return next_state


func process( delta: float ) -> PlayerState:
	return next_state


func physics_process(delta: float) -> PlayerState:
	return next_state
