extends ParallaxBackground

@export_range(1, 6) var speed:int = 4

var is_movement_stopped = false

func _process(_delta):
	if not is_movement_stopped:
		scroll_base_offset += Vector2(-speed, 0)

func _on_game_manager_movement_stopped():
	is_movement_stopped = true
