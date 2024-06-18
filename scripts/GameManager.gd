extends Node2D
class_name GameManager

var score:int = 0
var is_movement_stopped:bool = false
var is_game_over:bool = false

signal score_added(total_score:int)
signal movement_stopped
signal game_over(total_score:int)

func _on_ground_body_entered(_body):
	if not is_movement_stopped:
		movement_stopped.emit()
	if not is_game_over:
		game_over.emit(score)

func _on_pipe_passed():
	score += 1
	score_added.emit(score)

func _on_pipe_collision():
	if not is_movement_stopped:
		movement_stopped.emit()
