class_name EnemyDestroyedState extends EnemyState

@export var anim_name: String = "destroy"
@export var knockback_speed: float = 100
@export var decelerate_speed: float = 10

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

var _damage_pos: Vector2
var _direction: Vector2

func init() -> void:
	enemy.enemy_destroyed.connect(_on_enemy_destroyed)
	
func enter() -> void:
	enemy.invulnerable = true
	_direction = enemy.global_position.direction_to(_damage_pos)
	enemy.set_direction(_direction)
	enemy.velocity = -knockback_speed * _direction
	enemy.update_animation(anim_name)
	animation_player.animation_finished.connect(_on_anim_finished, CONNECT_ONE_SHOT)

func exit() -> void:
	enemy.invulnerable = false
	
func process(delta: float) -> State:
	enemy.velocity -= enemy.velocity * decelerate_speed * delta
	return null
	
func _on_enemy_destroyed(hurtbox: Hurtbox) -> void:
	_damage_pos = hurtbox.global_position
	state_machine.change_state(self)

func _on_anim_finished(_anim_name: String) -> void:
	queue_free()
	enemy.queue_free()
