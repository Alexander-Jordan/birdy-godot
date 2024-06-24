extends Node2D

func _ready():
	call_deferred('setup_game')

func setup_game():
	SaveSystem.load_persisted_nodes()

func _notification(what:int):
	# make sure to always save before closing down the game
	# NOTIFICATION_WM_GO_BACK_REQUEST is used for an android back-button
	if what == NOTIFICATION_WM_CLOSE_REQUEST or what == NOTIFICATION_WM_GO_BACK_REQUEST:
		SaveSystem.save_persisted_nodes()
		get_tree().quit()
