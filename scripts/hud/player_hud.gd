extends Node

var hearts: Array[HeartGUI] = []

@onready var h_flow_container: HFlowContainer = $Control/HFlowContainer

func _ready() -> void:
	for child in h_flow_container.get_children():
		if child is HeartGUI:
			hearts.append(child)
			child.visible = false

func update_hp(hp: int, max_hp: int) -> void:
	update_max_hp(max_hp)
	for i in int(max_hp / 2.0):
		update_heart(i, hp)

func update_heart(index: int, hp: int) -> void:
	if hearts.size() <= index:
		return
		
	var value: int = clampi(hp - 2 * index, 0, 2)
	hearts[index].heart_frame = value
	
func update_max_hp(max_hp: int) -> void:
	var count: int = round(max_hp / 2.0)
	for i in hearts.size():
		hearts[i].visible = i < count
