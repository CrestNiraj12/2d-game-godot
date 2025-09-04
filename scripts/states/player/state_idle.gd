class_name IdleState extends PlayerState

@onready var walk: WalkState = $"../Walk"

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
