class_name EnemyStunState extends EnemyState

@export var anim_name: String = "stun"
@export var knockback_speed: float = 100
@export var decelerate_speed: float = 10

var _damage_pos: Vector2
var _direction: Vector2
var _anim_finished: bool = true

func init() -> void:
	enemy.enemy_damaged.connect(_on_enemy_damaged)
	
func enter() -> void:
	_anim_finished = false
	enemy.invulnerable = true
	
	_direction = enemy.global_position.direction_to(_damage_pos)
	enemy.set_direction(_direction)
	enemy.velocity = -knockback_speed * _direction
	enemy.update_animation(anim_name)
	enemy.animation_player.animation_finished.connect(_on_anim_finished)

func exit() -> void:
	enemy.invulnerable = false
	enemy.animation_player.animation_finished.disconnect(_on_anim_finished)
	
func process(delta: float) -> State:
	if _anim_finished:
		return next_state
	
	enemy.velocity -= enemy.velocity * decelerate_speed * delta
	return null

func _on_enemy_damaged(hurtbox: Hurtbox) -> void:
	_damage_pos = hurtbox.global_position
	state_machine.change_state(self)

func _on_anim_finished(_anim_name: String) -> void:
	_anim_finished = true
