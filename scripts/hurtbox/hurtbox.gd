class_name Hurtbox extends Area2D

@export_range(0.5, 3, 0.5) var damage: float = 1

func _ready() -> void:
	area_entered.connect(_area_entered)
	
func _area_entered(a: Area2D) -> void:
	if a is Hitbox:
		a.take_damage(damage)
