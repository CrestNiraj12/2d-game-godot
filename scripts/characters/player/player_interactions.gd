class_name PlayerInteractions extends Node2D

@onready var player: Player = $".."

func _ready() -> void:
	player.direction_changed.connect(update_direction)

func update_direction(direction: Vector2) -> void:
	match direction:
		Vector2.UP:
			rotation_degrees = 180
		Vector2.LEFT:
			rotation_degrees = 90
		Vector2.RIGHT:
			rotation_degrees = -90
		Vector2.DOWN, _:
			rotation_degrees = 0
