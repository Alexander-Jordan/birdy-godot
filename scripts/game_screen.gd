extends VBoxContainer

@onready var points_label = $points_label

func _on_start_screen_start_game():
	visible = true

func _on_game_manager_score_added():
	points_label.text = str(SaveSystem.game_stats_data.last_score)

func _on_game_manager_game_over():
	visible = false
