class_name PlayerStateFall extends PlayerState

@export var coyote_time : float = 0.5

var time_in_state : float

func init() -> void:
	pass


func enter() -> void:
	player.add_debug_indicator( Color.YELLOW )
	time_in_state = 0


func exit() -> void:
	player.add_debug_indicator( Color.RED )


func handle_input( event: InputEvent ) -> PlayerState:
	if event.is_action_pressed( "jump" ) and player.previous_state != jump and time_in_state < coyote_time:
		return jump

	return next_state


func process( delta: float ) -> PlayerState:
	if player.is_on_floor():
		return idle
	time_in_state += delta
	return next_state


func physics_process(delta: float) -> PlayerState:
	player.velocity.x = player.direction.x * player.move_speed
	return next_state
