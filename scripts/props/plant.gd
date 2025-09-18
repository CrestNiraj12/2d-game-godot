class_name Plant extends Node2D

@onready var hitbox: Hitbox = $Hitbox

func _ready() -> void:
	hitbox.damaged.connect(_take_damage)
	
func _take_damage(_hurtbox: Hurtbox) -> void:
	queue_free()
