class_name WalkState extends PlayerState

@export var speed: float = 100
@onready var idle: IdleState = $"../Idle"

func enter() -> void:
	player.update_animation("walk")
	
func process(_delta: float) -> State:	
	if player.direction == Vector2.ZERO:
		return idle
		
	player.velocity = player.direction * speed
	if player.set_direction():
		player.update_animation("walk")
	return null
