extends CharacterBody2D
class_name Bird

@export var audio_flap:AudioStream
@export var audio_collide:AudioStream
@export var audio_dead:AudioStream

@onready var animation_player:AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player_2D = $AudioStreamPlayer2D

var game_started:bool = false
var gravity = ProjectSettings.get_setting('physics/2d/default_gravity')
var flap_speed = -1000
var is_movement_stopped:bool = false

func _process(_delta):
	if not is_movement_stopped and Input.is_action_just_pressed('flap'):
		animation_player.play('flap')
		animation_player.queue('idle')
		audio_stream_player_2D.stream = audio_flap
		audio_stream_player_2D.play()

func _physics_process(delta):
	if game_started:
		velocity.y += gravity * delta
	
	if not is_movement_stopped and Input.is_action_just_pressed('flap'):
		velocity.y = flap_speed
	
	move_and_slide()

func _on_start_game():
	game_started = true

func _on_game_manager_movement_stopped():
	is_movement_stopped = true

func _on_pipe_collision():
	if not animation_player.current_animation == 'collide':
		animation_player.play('collide')
		audio_stream_player_2D.stream = audio_collide
		audio_stream_player_2D.play()

func _on_ground_body_entered(_body):
	if not animation_player.current_animation == 'dead':
		animation_player.play('dead')
		audio_stream_player_2D.stream = audio_dead
		audio_stream_player_2D.play()
