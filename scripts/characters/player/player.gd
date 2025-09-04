class_name Player extends Character 

func _ready() -> void:
	super._ready()
	PlayerManager.player = self
	
func _process(_delta: float) -> void:
	direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	).normalized()
