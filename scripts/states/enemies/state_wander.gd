class_name EnemyWanderState extends EnemyState

@export var anim_name: String = "walk"
@export var wander_speed: float = 20

@export_category("AI")
@export var state_animation_duration: float = 0.7
@export var min_state_cycles: int = 1
@export var max_state_cycles: int = 3

var _timer: float = 0
var _direction: Vector2

func enter() -> void:
	_timer = randi_range(min_state_cycles, max_state_cycles) * state_animation_duration
	var rand: int = randi_range(0, 3)
	_direction = enemy.DIR_4[rand]
	enemy.velocity = _direction * wander_speed
	enemy.set_direction(_direction)
	enemy.update_animation(anim_name)
	
func process(delta: float) -> State:
	_timer -= delta
	if _timer > 0:
		return null
	return next_state
	
func physics(_delta: float) -> State:
	return null
