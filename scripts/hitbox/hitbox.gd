class_name Hitbox extends Area2D

signal damaged(damage: float)

func take_damage(damage: float) -> void:
	damaged.emit(damage)
