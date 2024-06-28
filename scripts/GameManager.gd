extends Node2D
class_name GameManager

@onready var music_player = $music_player
@onready var point_audio_player = $point_audio_player

var game_stats_data:GameStatsData = GameStatsData.new()
var save_file_name:String = 'game_stats_data.tres'
var is_movement_stopped:bool = false
var is_game_over:bool = false

signal score_added(total_score:int)
signal movement_stopped
signal game_over(total_score:int, medal:int, best_score:int)

func save_data(base_path:String):
	game_stats_data.add_medal()
	ResourceSaver.save(game_stats_data, base_path + save_file_name)

func load_data(base_path:String):
	if ResourceLoader.exists(base_path + save_file_name):
		game_stats_data = ResourceLoader.load(base_path + save_file_name).duplicate(true)

func _on_start_game():
	game_stats_data.games_count += 1
	game_stats_data.last_score = 0
	music_player.play()

func _on_pipe_passed():
	# increment points
	game_stats_data.pipes_passed += 1
	game_stats_data.last_score += 1
	score_added.emit(game_stats_data.last_score)
	point_audio_player.play()

func _on_pipe_collision():
	if not is_movement_stopped:
		music_player.stop()
		movement_stopped.emit()

func _on_ground_collision():
	if not is_movement_stopped: 
		movement_stopped.emit()
	if not is_game_over:
		music_player.stop()
		game_over.emit(game_stats_data.last_score, game_stats_data.last_medal, game_stats_data.best_score)
		
		if game_stats_data.last_score == 0:
			game_stats_data.deaths_witch_zero_points += 1
		
		SaveSystem.save_persisted_nodes()

func _on_bird_flap():
	game_stats_data.flaps += 1
