class_name Enemy extends Character 

signal enemy_damaged(hurtbox: Hurtbox)
signal enemy_destroyed(hurtbox: Hurtbox)

@export var hp: int = 3

@onready var hitbox: Hitbox = $Hitbox

var invulnerable: bool = false

func _ready() -> void:
	super._ready()
	hitbox.damaged.connect(_take_damage)

func _take_damage(hurtbox: Hurtbox) -> void:
	if invulnerable:
		return
		
	hp -= hurtbox.damage
	if hp > 0:
		enemy_damaged.emit(hurtbox)
		return
		
	enemy_destroyed.emit(hurtbox)
