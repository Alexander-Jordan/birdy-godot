extends Node2D
class_name Pipe

@export_enum('Bottom', 'Top') var type:String = 'Bottom'

@onready var pipe_sprite_2D:Sprite2D = $pipe_sprite_2D
@onready var pipe_top_sprite_2D:Sprite2D = $pipe_top_sprite_2D
@onready var area_2D:Area2D = $Area2D
@onready var screen_size:Vector2 = get_viewport_rect().size

signal pipe_collision

func _ready():
	area_2D.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D):
	if body is Bird:
		pipe_collision.emit()
		print('bird hit')

func position_and_scale_pipe():
	var pixels_from_edge:float = global_position.y if type == 'Top' else screen_size.y - global_position.y
	var pipe_original_y_size:float = pipe_sprite_2D.region_rect.size.y * scale.y
	var pipe_y_scale:float = pixels_from_edge / pipe_original_y_size
	pipe_sprite_2D.scale.y = pipe_y_scale
	area_2D.scale = pipe_sprite_2D.scale
	
	pipe_sprite_2D.flip_h = type == 'Top'
	pipe_top_sprite_2D.flip_h = type == 'Top'
	
	rotation_degrees = 180 if type == 'Top' else 0
