class_name Slime extends CharacterBody2D

signal direction_changed(direction: Vector2)
signal enemy_damaged()

@export var hp: int = 3

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D

const DIR_4: Array[Vector2] = [ Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP ]

var main_direction: Vector2 = Vector2.DOWN
var direction: Vector2 = Vector2.ZERO
var player: Player
var invulnerable: bool = false

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	move_and_slide()
	
func set_direction(dir: Vector2) -> bool:
	direction = dir
	if direction == Vector2.ZERO:
		return false
	
	var dir_id: int = int(round((direction + main_direction * 0.1).angle() / TAU * DIR_4.size()))
	var new_dir = DIR_4[dir_id]
	
	if new_dir == main_direction:
		return false
	
	main_direction = new_dir
	direction_changed.emit(new_dir)
	sprite.scale.x = -1 if main_direction == Vector2.LEFT else 1
	return true

func update_animation(state: String) -> void:
	animation_player.play(state + "_" + get_direction())
	
func get_direction() -> String:
	if main_direction == Vector2.DOWN:
		return "down"
	elif main_direction == Vector2.UP:
		return "up"
	else:
		return "side"
