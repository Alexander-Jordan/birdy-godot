extends Node2D
class_name GameManager

var is_movement_stopped:bool = false
var is_game_over:bool = false

signal movement_stopped
signal game_over

func _on_ground_body_entered(body):
	if not is_movement_stopped:
		movement_stopped.emit()
	if not is_game_over:
		game_over.emit()

func _on_pipe_collision():
	if not is_movement_stopped:
		movement_stopped.emit()
