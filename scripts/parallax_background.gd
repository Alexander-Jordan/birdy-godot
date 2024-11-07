extends Node

@export_range(100, 200) var parallax_speed_1:int = 176
@export_range(200, 400) var parallax_speed_2:int = 235

@onready var parallax_background_1 = $ParallaxBackground1
@onready var parallax_background_2 = $ParallaxBackground2

var is_movement_stopped = false
var is_ground_collided = false

signal ground_collision

func _process(delta):
	if not is_movement_stopped:
		parallax_background_1.scroll_base_offset += Vector2(-parallax_speed_1, 0) * delta
		parallax_background_2.scroll_base_offset += Vector2(-parallax_speed_2, 0) * delta

func _on_game_manager_movement_stopped():
	is_movement_stopped = true

func _on_ground_body_entered(body):
	if is_ground_collided or (not body is Bird):
		return
	
	is_ground_collided = true
	ground_collision.emit()
