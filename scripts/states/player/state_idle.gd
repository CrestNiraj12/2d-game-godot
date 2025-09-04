class_name IdleState extends State

@onready var walk: WalkState = $"../Walk"
@onready var attack: AttackState = $"../Attack"

func enter() -> void:
	player.update_animation("idle")
	
func exit() -> void:
	pass
	
func process(_delta: float) -> State:
	if player.direction != Vector2.ZERO:
		return walk
		
	player.velocity = Vector2.ZERO
	return null
	
func physics(_delta: float) -> State:
	player.velocity = Vector2.ZERO
	return null

func handle_input(_input_event: InputEvent) -> State:
	if _input_event.is_action_pressed("attack"):
		return attack
	return null
