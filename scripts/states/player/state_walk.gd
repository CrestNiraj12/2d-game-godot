class_name WalkState extends State

@export var speed: float = 100
@onready var idle: IdleState = $"../Idle"
@onready var attack: AttackState = $"../Attack"

func enter() -> void:
	player.update_animation("walk")
	
func exit() -> void:
	pass
	
func process(_delta: float) -> State:	
	if player.direction == Vector2.ZERO:
		return idle
		
	player.velocity = player.direction * speed
	if player.set_direction():
		player.update_animation("walk")
	return null
	
func physics(_delta: float) -> State:
	return null

func handle_input(_input_event: InputEvent) -> State:
	if _input_event.is_action_pressed("attack"):
		return attack
	return null
