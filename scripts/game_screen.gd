extends VBoxContainer

@onready var points_label = $points_label

func _on_start_screen_start_game():
	visible = true

func _on_game_manager_score_added(total_score:int):
	points_label.text = str(total_score)

func _on_game_manager_game_over(_total_score:int, _medal:int, _best_score:int):
	visible = false
