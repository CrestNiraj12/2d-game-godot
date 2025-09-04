class_name Plant extends Node2D

@onready var hitbox: Hitbox = $Hitbox

func _ready() -> void:
	hitbox.damaged.connect(take_damage)
	
func take_damage(_damage: float) -> void:
	queue_free()
