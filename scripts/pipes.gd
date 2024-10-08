extends Node2D
class_name Pipes

@export_range(1, 6) var speed:int = 235

@onready var pipes:Array[Pipe] = [$pipe_top, $pipe_bottom]

var velocity:Vector2 = Vector2(-speed, 0)
var is_movement_stopped:bool = false

signal screen_entered
signal screen_exited
signal pipe_passed
signal pipe_collision

func _ready():
	var visible_on_screen_notifier_2D:VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
	visible_on_screen_notifier_2D.screen_entered.connect(func(): self.screen_entered.emit())
	visible_on_screen_notifier_2D.screen_exited.connect(func(): self.screen_exited.emit())

func _process(delta):
	if not is_movement_stopped:
		translate(velocity * delta)

func position_and_scale_pipes():
	for pipe:Pipe in pipes:
		pipe.position_and_scale_pipe()
		if not pipe.pipe_collision.is_connected(emit_pipe_collision):
			pipe.pipe_collision.connect(emit_pipe_collision)

func emit_pipe_collision():
	pipe_collision.emit()

func _on_pipe_edge_body_exited(body:Node2D):
	if body is Bird and !is_movement_stopped:
		pipe_passed.emit()
