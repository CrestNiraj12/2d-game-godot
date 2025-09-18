extends CanvasLayer

@onready var save_button: Button = $VBoxContainer/SaveButton
@onready var load_button: Button = $VBoxContainer/LoadButton

var is_paused: bool = false

enum Action {
	SAVE,
	LOAD,
}

func _ready() -> void:
	_set_pause(false)
	save_button.pressed.connect(func(): _on_button_pressed(Action.SAVE))
	load_button.pressed.connect(func(): _on_button_pressed(Action.LOAD))
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		_set_pause(!is_paused)
			
	get_viewport().set_input_as_handled()
	
func _set_pause(shouldPause: bool) -> void:
	get_tree().paused = shouldPause
	visible = shouldPause
	is_paused = shouldPause
	
	if shouldPause:
		save_button.grab_focus()

func _on_button_pressed(action: Action) -> void:
	if not is_paused:
		return
		
	match action:
		Action.SAVE:
			StateManager.save_game()
		Action.LOAD:
			StateManager.load_game()
			await LevelManager.level_loaded
	
	_set_pause(false)
