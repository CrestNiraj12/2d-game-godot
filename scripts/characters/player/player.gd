class_name Player extends Character 

@onready var effect_animation_player: AnimationPlayer = $EffectAnimationPlayer
@onready var hitbox: Hitbox = $Hitbox

@export var hp: int = 6
@export var max_hp: int = 6

signal player_damaged(hurtbox: Hurtbox)

var is_invulerable: bool = false

func _ready() -> void:
	super._ready()
	PlayerManager.player = self
	hitbox.damaged.connect(_take_damage)
	update_hp(99)
	
func _process(_delta: float) -> void:
	direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	).normalized()

func _take_damage(hurtbox: Hurtbox) -> void:
	if is_invulerable:
		return
	
	update_hp(-hurtbox.damage)
	if hp > 0:
		player_damaged.emit(hurtbox)
	else:
		update_hp(99)
	
func update_hp(delta: int) -> void:
	hp = clampi(hp+delta, 0, max_hp)
	PlayerHud.update_hp(hp, max_hp)
	
func make_invulnerable(duration: float = 1) -> void:
	is_invulerable = true
	hitbox.monitoring = false
	await get_tree().create_timer(duration).timeout
	hitbox.monitoring = true
	is_invulerable = false
