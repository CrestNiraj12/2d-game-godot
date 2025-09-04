class_name PlayerStateMachine extends StateMachine

func initialize(player: Character) -> void:
	if !(player is Player):
		return
		
	states = []
	for c in get_children():
		if c is PlayerState:
			states.append(c)
	
	if states.size() > 0:
		var f_state: PlayerState = states[0]
		f_state.player = player
		change_state(f_state)
		process_mode = Node.PROCESS_MODE_INHERIT
