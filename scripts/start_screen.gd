extends VBoxContainer

var game_started:bool = false

signal start_game

func _input(event):
	if not game_started:
		return
	
	if and event.is_action_pressed("flap"):
		game_started = true
		start_game.emit()
		visible = false
