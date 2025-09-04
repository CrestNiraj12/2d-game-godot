class_name AttackState extends PlayerState

@onready var idle: IdleState = $"../Idle"
@onready var walk: WalkState = $"../Walk"

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var attack_anim: AnimationPlayer = $"../../Sprite2D/AttackSprite/AnimationPlayer"
@onready var audio_stream: AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"
@onready var hurtbox: Hurtbox = %Hurtbox

@export var attack_sound: AudioStream
@export_range(1, 20, 0.5) var decelerate_speed: float = 5

var attacking: bool = false

func enter() -> void:
	player.update_animation("attack")
	attack_anim.play("attack_" + player.get_direction())
	animation_player.animation_finished.connect(end_attack)
	
	audio_stream.stream = attack_sound
	audio_stream.pitch_scale = randf_range(0.9, 1.1)
	audio_stream.play()
	
	attacking = true
	await get_tree().create_timer(0.075).timeout
	hurtbox.monitoring = true
	
func exit() -> void:
	animation_player.animation_finished.disconnect(end_attack)
	attacking = false
	hurtbox.monitoring = false
	
func process(_delta: float) -> State:
	player.velocity -= player.velocity * decelerate_speed * _delta
	
	if !attacking:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return walk
	return null
	
func physics(_delta: float) -> State:
	return null

func handle_input(_input_event: InputEvent) -> State:
	return null

func end_attack(_newAnim: String) -> void:
	attacking = false
