class_name Enemy extends Character 

signal enemy_damaged()

@export var hp: int = 3

var player: Player
var invulnerable: bool = false

func _ready() -> void:
	super._ready()
	player = PlayerManager.player
