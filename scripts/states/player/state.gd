class_name PlayerState extends State

static var player: Player
static var state_machine: PlayerStateMachine

@onready var attack: AttackState = $"../Attack"

func handle_input(_input_event: InputEvent) -> State:
	if _input_event.is_action_pressed("attack"):
		return attack
	return null
