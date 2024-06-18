extends Node2D

@export_range(1, 6) var number_of_spawn_positions:int = 3
@export_range(1, 3, 0.1) var respawn_delay:float = 2
@export var pipes_scene:PackedScene

@onready var screen_size:Vector2 = get_viewport_rect().size

var pool:Array[Pipes] = []
var spawn_positions:Array[Vector2]
var last_spawn_position:Vector2 = Vector2.ZERO
var rng:RandomNumberGenerator = RandomNumberGenerator.new()
var is_movement_stopped:bool = false

signal pipe_passed
signal pipe_collision
signal movement_stopped

func init_spawn_positions():
	var x_pos = screen_size.x + 0
	var dist_between_positions:float = screen_size.y / (number_of_spawn_positions + 1)
	for index in number_of_spawn_positions:
		spawn_positions.append(Vector2(x_pos, dist_between_positions * (index + 1)))

func _ready():
	init_spawn_positions()

func get_pipes_instance() -> Pipes:
	if pool.is_empty():
		var pipes:Pipes = pipes_scene.instantiate()
		add_child(pipes)
		# setup signal connections
		pipes.screen_entered.connect(spawn_pipes)
		pipes.screen_exited.connect(func(): pool.append(pipes))
		pipes.pipe_passed.connect(func(): self.pipe_passed.emit())
		pipes.pipe_collision.connect(func(): self.pipe_collision.emit())
		movement_stopped.connect(func(): pipes.is_movement_stopped = true)
		return pipes
	return pool.pop_front()

func spawn_pipes():
	# wait for some time before doing anything else
	await get_tree().create_timer(respawn_delay).timeout
	# check if movement has stopped before continuing
	if is_movement_stopped:
		return
	
	var pipes:Pipes = self.get_pipes_instance()
	pipes.position = get_unique_spawn_position()
	pipes.position_and_scale_pipes()

func get_unique_spawn_position() -> Vector2:
	var filtered_positions = spawn_positions.filter(func(spawn_pos): return spawn_pos != last_spawn_position)
	last_spawn_position = filtered_positions[rng.randi_range(0, filtered_positions.size() - 1)]
	return last_spawn_position

func _on_start_game():
	spawn_pipes()

func _on_game_manager_movement_stopped():
	is_movement_stopped = true
	movement_stopped.emit()
