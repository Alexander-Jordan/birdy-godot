extends VBoxContainer

var game_started:bool = false

signal start_game

func _unhandled_input(event):
	if game_started:
		return
	
	if event.is_action_pressed("flap"):
		game_started = true
		start_game.emit()
		visible = false
