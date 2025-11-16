class_name Player extends CharacterBody2D

const DEBUG_JUMP_INDICATOR = preload("uid://ct7jlp1pjieu2")

#region Properties
@export_range(0, 100, 1, "or_greater") var move_speed: float = 150
@export_range(0, 1, 0.025) var friction: float = 0.75
#endregion

#region Nodes
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_standing: CollisionShape2D = $CollisionStanding
@onready var collision_crouching: CollisionShape2D = $CollisionCrouching
@onready var one_way_platform_shape_cast: ShapeCast2D = $OneWayPlatformShapeCast
#endregion

#region State Machine
var states : Array[PlayerState]
var current_state : PlayerState:
	get : return states.front() if not states.is_empty() else null
var previous_state : PlayerState:
	get : return states[1]
#endregion

#region Player state
var direction: Vector2 = Vector2.ZERO
var gravity_modifier: float = 1
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
		velocity += get_gravity() * delta * gravity_modifier
	$Debug/Velocity.text = str(velocity)
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
	if current_state:
		current_state.exit()
	states.push_front(new_state)
	current_state.enter()
	states.resize(3)
	$Debug/State.text = current_state.name


func update_direction() -> void:
	var x_axis = Input.get_axis("left", "right")
	var y_axis = Input.get_axis("up", "down")
	direction = Vector2(x_axis, y_axis)


func add_debug_indicator(color : Color) -> void:
	var d : Node2D = DEBUG_JUMP_INDICATOR.instantiate()
	d.global_position = global_position
	d.modulate = color
	get_tree().root.add_child(d)
	await get_tree().create_timer( 3 ).timeout
	d.queue_free()
