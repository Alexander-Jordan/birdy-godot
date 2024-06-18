extends VBoxContainer

@onready var restart_button = $restart_button
@onready var score = $Control/VBoxContainer/score

func _ready():
	restart_button.pressed.connect(restart_game)

func restart_game():
	# for now, just reload the current scene
	get_tree().reload_current_scene()

func _on_game_manager_game_over(total_score:int):
	score.text = str(total_score)
	visible = true
