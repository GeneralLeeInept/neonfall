class_name Player extends CharacterBody2D

@export var player_speed: int = 100

#region State Machine
var states : Array[PlayerState]
var current_state : PlayerState:
	get : return states.front()
var previous_state : PlayerState:
	get : return states[1]
#endregion

#region Player state
var direction : Vector2 = Vector2.ZERO
#endregion

func _ready() -> void:
	initialize_states()


func _unhandled_input(event: InputEvent) -> void:
	change_state( current_state.handle_input( event ) )


func _process(delta: float) -> void:
	update_direction()
	change_state( current_state.process( delta ) )


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()
	change_state( current_state.physics_process( delta ) )


func initialize_states() -> void:
	for state in $States.get_children().filter( func( x ): return x is PlayerState ):
		state.player = self
		state.init()
	change_state( $States/Idle )


func change_state( new_state: PlayerState ) -> void:
	if new_state == null:
		return
	if new_state == current_state:
		return
	if current_state:
		current_state.exit()
	states.push_front(new_state)
	current_state.enter()
	states.resize(3)


func update_direction() -> void:
	direction = Input.get_vector("left", "right", "up", "down" )
