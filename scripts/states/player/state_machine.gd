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

func initialize(player: Player) -> void:
	states = []
	for c in get_children():
		if c is State:
			states.append(c)
	
	if states.size() > 0:
		var f_state: State = states[0]
		f_state.player = player
		change_state(f_state)
		process_mode = Node.PROCESS_MODE_INHERIT

func change_state(state: State) -> void:
	if state == null || curr_state == state:
		return
		
	if curr_state:
		curr_state.exit()
		
	prev_state = curr_state
	curr_state = state
	curr_state.enter()
