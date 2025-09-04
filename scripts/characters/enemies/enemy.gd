class_name Enemy extends Character 

signal enemy_damaged()
signal enemy_destroyed()

@export var hp: int = 3

@onready var hitbox: Hitbox = $Hitbox

var invulnerable: bool = false

func _ready() -> void:
	super._ready()
	hitbox.damaged.connect(_take_damage)

func _take_damage(damage: int) -> void:
	if invulnerable:
		return
		
	hp -= damage
	if hp > 0:
		enemy_damaged.emit()
		return
		
	enemy_destroyed.emit()
