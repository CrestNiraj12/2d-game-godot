class_name PlayerStunState extends PlayerState

@onready var idle: IdleState = $"../Idle"

@export var anim_name: String = "stun"
@export var damaged_anim_name: String = "damaged"
@export var knockback_speed: float = 100
@export var decelerate_speed: float = 10
@export var invulnerable_duration: float = 1

var _damage_pos: Vector2
var direction: Vector2
var next_state: PlayerState = null

func init() -> void:
	player.player_damaged.connect(_player_damaged)
	
func enter() -> void:
	player.animation_player.animation_finished.connect(_anim_finished)
	direction = player.global_position.direction_to(_damage_pos)
	player.velocity = -knockback_speed * direction
	player.set_direction()
	player.update_animation(anim_name)
	player.make_invulnerable(invulnerable_duration)
	player.effect_animation_player.play(damaged_anim_name)

func exit() -> void:
	next_state = null
	player.animation_player.animation_finished.disconnect(_anim_finished)
	
func process(delta: float) -> State:
	player.velocity -= player.velocity * decelerate_speed * delta
	return next_state

func _player_damaged(hurtbox: Hurtbox) -> void:
	_damage_pos = hurtbox.global_position
	state_machine.change_state(self)

func _anim_finished(_anim_name: String) -> void:
	next_state = idle
