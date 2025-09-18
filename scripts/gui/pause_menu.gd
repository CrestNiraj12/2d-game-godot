extends CanvasLayer

@onready var save_button: Button = $VBoxContainer/SaveButton
@onready var load_button: Button = $VBoxContainer/LoadButton

var is_paused: bool = false

func _ready() -> void:
	_set_pause(false)
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		_set_pause(!is_paused)
			
	get_viewport().set_input_as_handled()
	
func _set_pause(shouldPause: bool) -> void:
	get_tree().paused = shouldPause
	visible = shouldPause
	is_paused = shouldPause
