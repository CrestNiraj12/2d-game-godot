extends Node

const PLAYER = preload("res://scenes/player/player.tscn")

var player: Player
var player_spawned: bool = false

func _ready() -> void:
	add_player_instance()
	await get_tree().create_timer(0.2).timeout
	player_spawned = true

func add_player_instance() -> void:
	player = PLAYER.instantiate() 

func set_player_pos(new_pos: Vector2) -> void:
	player.global_position = new_pos

func set_player_health(hp: int, max_hp: int) -> void:
	player.hp = hp
	player.max_hp = max_hp
	player.update_hp(0)

func set_player_parent(node: Node2D) -> void:
	var parent: Node = player.get_parent()
	if parent:
		parent.remove_child(player)
		
	node.add_child(player)

func unparent_player(parent: Node2D) -> void:
	parent.remove_child(player)
