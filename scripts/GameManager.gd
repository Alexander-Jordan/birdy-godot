extends Node2D
class_name GameManager

@export var audio_point:AudioStream

@onready var audio_stream_player = $AudioStreamPlayer

var game_stats_data:GameStatsData = GameStatsData.new()
var save_file_name:String = 'game_stats_data.tres'
var score:int = 0
var is_movement_stopped:bool = false
var is_game_over:bool = false

signal score_added(total_score:int)
signal movement_stopped
signal game_over(total_score:int, best_score:int)

func save_data(base_path:String):
	ResourceSaver.save(game_stats_data, base_path + save_file_name)

func load_data(base_path:String):
	if ResourceLoader.exists(base_path + save_file_name):
		game_stats_data = ResourceLoader.load(base_path + save_file_name).duplicate(true)

func _on_pipe_passed():
	# increment points
	score += 1
	score_added.emit(score)
	
	# is it a new best score?
	if score > game_stats_data.best_score:
		game_stats_data.best_score = score
	
	# play audio
	audio_stream_player.stream = audio_point
	audio_stream_player.play()

func _on_pipe_collision():
	if not is_movement_stopped:
		movement_stopped.emit()

func _on_ground_body_entered(_body):
	if not is_movement_stopped: 
		movement_stopped.emit()
	if not is_game_over:
		game_over.emit(score, game_stats_data.best_score)
		SaveSystem.save_persisted_nodes()
