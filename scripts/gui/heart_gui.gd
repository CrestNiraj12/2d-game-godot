class_name HeartGUI extends Control

@onready var sprite: Sprite2D = $Sprite2D

var heart_frame: int = 2:
	set(val):
		heart_frame = val
		update_heart()

func update_heart() -> void:
	sprite.frame = heart_frame
