extends Node2D
class_name GameManager

var is_movement_stopped:bool = false

signal movement_stopped

func _on_ground_body_entered(body):
	if not is_movement_stopped:
		movement_stopped.emit()

func _on_pipe_collision():
	if not is_movement_stopped:
		movement_stopped.emit()
