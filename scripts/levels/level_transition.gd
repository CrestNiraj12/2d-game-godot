@tool
class_name LevelTransition extends Area2D

enum SIDE {
	LEFT,
	RIGHT,
	TOP,
	BOTTOM
}

@export_file("*.tscn") var levelScene
@export var target_transition: String = "LevelTransition"

@export_category("Collision Area Settings")
@export_range(1, 12, 1, "or greater") var size: int = 2:
	set(val):
		size = val
		_update_area()
		
@export var side: SIDE = SIDE.LEFT:
	set(val):
		side = val
		_update_area()
		
@export var snap_to_grid: bool = false:
	set(val):
		snap_to_grid = val
		_snap_to_grid()

@onready var collision_shape: CollisionShape2D = $CollisionShape2D 

const DEFAULT_SIZE: int = 32
const OFFSET: int = int(DEFAULT_SIZE / 2.0)

func _ready() -> void:
	_update_area()
	if Engine.is_editor_hint():
		return
	
	monitoring = false
	_place_player()
	
	await LevelManager.level_loaded
	monitoring = true
	body_entered.connect(_player_entered)
	
	
func _place_player() -> void:
	if name != LevelManager.target_transition:
		return
		
	PlayerManager.set_player_pos(global_position + LevelManager.pos_offset)
	
func _update_area() -> void:
	var new_rect: Vector2 = Vector2(DEFAULT_SIZE, DEFAULT_SIZE)
	var pos: Vector2 = Vector2.ZERO
	
	if side == SIDE.TOP or side == SIDE.BOTTOM:
		new_rect.x *= size
		pos.y += OFFSET * (1 if side == SIDE.BOTTOM else -1)
	
	elif side == SIDE.LEFT or side == SIDE.RIGHT:
		new_rect.y *= size
		pos.x += OFFSET * (1 if side == SIDE.RIGHT else -1)

	if collision_shape == null:
		collision_shape = get_node("CollisionShape2D")
	
	collision_shape.shape.size = new_rect
	collision_shape.position = pos

func _snap_to_grid() -> void:
	position.x = round(position.x / 16) * 16
	position.y = round(position.y / 16) * 16

func _player_entered(_p: Node2D) -> void:
	LevelManager.load_new_level(levelScene, target_transition, _get_offset())

func _get_offset() -> Vector2:
	var offset: Vector2 = Vector2.ZERO
	var player_pos = PlayerManager.player.global_position
	
	if side == SIDE.LEFT or side == SIDE.RIGHT:
		offset.y = player_pos.y - global_position.y
		offset.x = OFFSET * (1 if side == SIDE.RIGHT else -1)
		
	elif side == SIDE.TOP or side == SIDE.BOTTOM:
		offset.x = player_pos.x - global_position.x
		offset.y = OFFSET * (1 if side == SIDE.BOTTOM else -1)
		
	return offset
