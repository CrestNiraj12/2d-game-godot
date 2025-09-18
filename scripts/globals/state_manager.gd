extends Node

const SAVE_PATH = "user://state.dat"

signal game_loaded
signal game_saved

var state: Dictionary = {
	scene_path = "",
	player = {
		hp = 1,
		max_hp = 1,
		pos = "",
	},
	items = [],
	persistence = [],
	quests = [],
}

func save_game() -> void:
	_update_scene_path()
	_update_state()
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var data = JSON.stringify(state)
	file.store_string(data)
	file.close()
	game_saved.emit()

func _update_scene_path() -> void:
	var scene := get_tree().current_scene
	if scene == null or scene is not Level:
		print("Error while saving! Invalid Scene!")
		return
		
	var p := scene.scene_file_path
	if p.strip_edges().is_empty():
		print("Error while saving! Invalid Scene File Path!")
		return
		
	state.scene_path = p
	
func _update_state() -> void:
	var p := PlayerManager.player
	state.player.hp = p.hp
	state.player.max_hp = p.max_hp
	state.player.pos = var_to_str(p.global_position)

func load_game() -> void:
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file == null:
		print("No save file found!")
		return
		
	var json := JSON.new()
	json.parse(file.get_line())
	file.close()
	
	state = json.get_data() as Dictionary
	var path: String = state.scene_path
	if path.strip_edges().is_empty():
		return
		
	LevelManager.load_new_level(path, "", Vector2.ZERO)
	await LevelManager.level_load_started
	
	var player: Dictionary = state.player
	PlayerManager.set_player_pos(str_to_var(player.pos))
	PlayerManager.set_player_health(player.hp, player.max_hp)
	
	await LevelManager.level_loaded
	game_loaded.emit()
