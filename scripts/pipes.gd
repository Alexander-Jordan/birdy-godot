extends Node2D
class_name Pipes

@export_range(1, 6) var speed:int = 4

@onready var pipes:Array[Pipe] = [$pipe_top, $pipe_bottom]

var velocity:Vector2 = Vector2(-speed, 0)
var is_movement_stopped:bool = false

signal screen_entered
signal screen_exited
signal pipe_collision

func _ready():
	var visible_on_screen_notifier_2D:VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
	visible_on_screen_notifier_2D.screen_entered.connect(func(): self.screen_entered.emit())
	visible_on_screen_notifier_2D.screen_exited.connect(func(): self.screen_exited.emit())

func _process(_delta):
	if not is_movement_stopped:
		translate(velocity)

func position_and_scale_pipes():
	for pipe:Pipe in pipes:
		pipe.position_and_scale_pipe()
		if not pipe.pipe_collision.is_connected(emit_pipe_collision):
			pipe.pipe_collision.connect(emit_pipe_collision)

func emit_pipe_collision():
	pipe_collision.emit()
