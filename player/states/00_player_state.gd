@icon("res://player/states/state.svg") 
class_name PlayerState extends Node

var player : Player
var next_state : PlayerState

#region State references

#endregion

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
