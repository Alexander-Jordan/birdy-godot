extends Node2D
class_name GameManager

@onready var music_player = $music_player
@onready var point_audio_player = $point_audio_player

var game_stats_data:GameStatsData = GameStatsData.new()
var save_file_name:String = 'game_stats_data.tres'
var score:int = 0
var medal:int = 0
var is_movement_stopped:bool = false
var is_game_over:bool = false

signal score_added(total_score:int)
signal movement_stopped
signal game_over(total_score:int, medal:int, best_score:int)

func save_data(base_path:String):
	ResourceSaver.save(game_stats_data, base_path + save_file_name)

func load_data(base_path:String):
	if ResourceLoader.exists(base_path + save_file_name):
		game_stats_data = ResourceLoader.load(base_path + save_file_name).duplicate(true)

func _on_start_game():
	music_player.play()

func _on_pipe_passed():
	# increment points
	score += 1
	score_added.emit(score)
	
	# is it a new best score?
	if score > game_stats_data.best_score:
		game_stats_data.best_score = score
	
	if score >= game_stats_data.point_for_bronze_medal:
		medal = 1
	if score >= game_stats_data.point_for_silver_medal:
		medal = 2
	if score >= game_stats_data.point_for_gold_medal:
		medal = 3
	if score >= game_stats_data.point_for_platinum_medal:
		medal = 4
	
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
		game_over.emit(score, medal, game_stats_data.best_score)
		game_stats_data.add_medal(medal)
		SaveSystem.save_persisted_nodes()
