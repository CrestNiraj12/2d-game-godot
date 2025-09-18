extends Node

var current_tilemap_bounds: Array[Vector2]
var target_transition: String
var pos_offset: Vector2

signal level_load_started
signal level_loaded
signal tilemap_bounds_changed(bounds: Array[Vector2])

func _ready() -> void:
	await get_tree().process_frame
	level_loaded.emit()

func change_tilemap_bounds(bounds: Array[Vector2]) -> void:
	current_tilemap_bounds = bounds
	tilemap_bounds_changed.emit(bounds)

func load_new_level(
	level_path: String, 
	target: String, 
	offset: Vector2,
) -> void:
	get_tree().paused = true
	target_transition = target
	pos_offset = offset
	
	await SceneTransition.fade_out()
	level_load_started.emit()
	
	await get_tree().process_frame
	get_tree().change_scene_to_file(level_path)
	
	await SceneTransition.fade_in()
	get_tree().paused = false
	
	await get_tree().process_frame
	
	level_loaded.emit()
