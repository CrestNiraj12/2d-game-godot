class_name EnemyIdleState extends EnemyState

@export var anim_name: String = "idle"
@export_category("AI")
@export var min_state_duration: float = 0.5
@export var max_state_duration: float = 1.5

var _timer: float = 0

func enter() -> void:
	enemy.velocity = Vector2.ZERO
	_timer = randf_range(min_state_duration, max_state_duration)
	enemy.update_animation(anim_name)
	
func exit() -> void:
	pass
	
func process(delta: float) -> State:
	_timer -= delta
	if _timer > 0:
		return null
	return next_state
