class_name StateMachine extends Node

var states: Array[State]
var prev_state: State
var curr_state: State

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED

func _process(delta: float) -> void:
	change_state(curr_state.process(delta))

func _physics_process(delta: float) -> void:
	change_state(curr_state.physics(delta))

func _unhandled_input(event: InputEvent) -> void:
	change_state(curr_state.handle_input(event))

func initialize(_character: Character) -> void:
	pass

func change_state(state: State) -> void:
	if state == null || curr_state == state:
		return
		
	if curr_state:
		curr_state.exit()
		
	prev_state = curr_state
	curr_state = state
	curr_state.enter()
