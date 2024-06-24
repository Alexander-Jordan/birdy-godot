extends Node2D

func _ready():
	call_deferred('setup_game')

func setup_game():
	SaveSystem.load_persisted_nodes()
