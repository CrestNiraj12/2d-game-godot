class_name EnemyStateMachine extends StateMachine
	
func initialize(enemy: Character) -> void:
	if !(enemy is Enemy):
		return
		
	states = []
	for c in get_children():
		if c is EnemyState:
			states.append(c)

	if states.size() <= 0:
		return
		
	for s in states:
		s.enemy = enemy
		s.state_machine = self
		s.init()
		
	change_state(states[0])
	process_mode = Node.PROCESS_MODE_INHERIT
