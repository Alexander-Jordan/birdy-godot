extends Node2D
class_name GameManager

@onready var music_player = $music_player
@onready var point_audio_player = $point_audio_player

var is_movement_stopped:bool = false
var is_game_over:bool = false

signal score_added
signal movement_stopped
signal game_over

func _on_start_game():
	SaveSystem.game_stats_data.games_count += 1
	SaveSystem.game_stats_data.last_score = 0
	music_player.play()

func _on_pipe_passed():
	# increment points
	SaveSystem.game_stats_data.pipes_passed += 1
	SaveSystem.game_stats_data.last_score += 1
	score_added.emit()
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
		game_over.emit()
		
		if SaveSystem.game_stats_data.last_score == 0:
			SaveSystem.game_stats_data.deaths_witch_zero_points += 1
		
		SaveSystem.save_data()
