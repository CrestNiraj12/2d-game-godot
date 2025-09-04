class_name State extends Node

func init() -> void:
	pass
	
func enter() -> void:
	pass
	
func exit() -> void:
	pass
	
func process(_delta: float) -> State:
	return null
	
func physics(_delta: float) -> State:
	return null

func handle_input(_input_event: InputEvent) -> State:
	return null
