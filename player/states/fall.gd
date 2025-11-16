class_name PlayerStateFall extends PlayerState

@export var coyote_time : float = 0.1
@export var jump_buffer_time : float = 0.1
@export var fall_gravity_modifier : float = 1.165


var coyote_timer : float
var jump_buffer : float
var jump_down : bool


func enter() -> void:
	player.add_debug_indicator( Color.YELLOW )
	if player.previous_state == jump:
		coyote_timer = 0
	else:
		coyote_timer = coyote_time
	jump_buffer = 0
	player.gravity_modifier = fall_gravity_modifier


func exit() -> void:
	player.add_debug_indicator( Color.RED )
	player.gravity_modifier = 1
	jump_buffer = 0


func handle_input( event: InputEvent ) -> PlayerState:
	if event.is_action_pressed( "jump" ):
		if coyote_timer > 0:
			return jump
		else:
			jump_buffer = jump_buffer_time
			jump_down = player.direction.y > 0.5
	return next_state


func process( delta: float ) -> PlayerState:
	if player.is_on_floor():
		if jump_buffer > 0:
			if jump_down and player.one_way_platform_shape_cast.is_colliding():
				player.position.y += 4
				return fall
			else:
				return jump
		return idle
		
	if coyote_timer > delta:
		coyote_timer -= delta
	else:
		coyote_timer = 0
	
	if jump_buffer > delta:
		jump_buffer -= delta
	else:
		jump_buffer = 0
	return next_state


func physics_process( _delta: float ) -> PlayerState:
	player.velocity.x = player.direction.x * player.move_speed
	return next_state
