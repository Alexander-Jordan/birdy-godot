extends VBoxContainer

@onready var restart_button:Button = $HBoxContainer/restart_button
@onready var menu_button:Button = $HBoxContainer/menu_button
@onready var score_label = $Control/VBoxContainer/score
@onready var best_score_label = $Control/VBoxContainer/best_score

func _ready():
	restart_button.pressed.connect(restart_game)
	menu_button.pressed.connect(load_menu)

func restart_game():
	# for now, just reload the current scene
	get_tree().reload_current_scene()

func load_menu():
	# for now, just change to the menu scene
	get_tree().change_scene_to_file('res://scenes/menu.tscn')

func _on_game_manager_game_over(total_score:int, best_score:int):
	score_label.text = str(total_score)
	best_score_label.text = str(best_score)
	visible = true
