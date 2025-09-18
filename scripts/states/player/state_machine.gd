class_name PlayerStateMachine extends StateMachine

func _unhandled_input(event: InputEvent) -> void:
	if curr_state == null:
		return
		
	change_state(curr_state.handle_input(event))
	
func initialize(player: Character) -> void:
	if !(player is Player):
		return
		
	states = []
	for c in get_children():
		if c is PlayerState:
			states.append(c)
	
	if states.size() <= 0:
		return
		
	var f_state: PlayerState = states[0]
	f_state.player = player
	f_state.state_machine = self
	
	for s in states:
		s.init()
		
	change_state(f_state)
	process_mode = Node.PROCESS_MODE_INHERIT
