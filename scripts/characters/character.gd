class_name Character extends CharacterBody2D

const DIR_4: Array[Vector2] = [ Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP ]
var main_direction: Vector2 = Vector2.DOWN
var direction: Vector2 = Vector2.ZERO

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var state_machine: StateMachine = $StateMachine

signal direction_changed(direction: Vector2)

func _ready() -> void:
	if state_machine && state_machine.has_method("initialize"):
		state_machine.call("initialize", self)
	
func _physics_process(_delta: float) -> void:
	move_and_slide()

func set_direction(new_dir: Variant = null) -> bool:
	if new_dir is Vector2:
		direction = new_dir

	if direction == Vector2.ZERO:
		return false
	
	var dir_id: int = int(round((direction + main_direction * 0.1).angle() / TAU * DIR_4.size()))
	var new_direction = DIR_4[dir_id]
	
	if new_direction == main_direction:
		return false
	
	main_direction = new_direction
	direction_changed.emit(new_direction)
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
