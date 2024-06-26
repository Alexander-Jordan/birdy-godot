extends VBoxContainer

@export var bus_name:String

@onready var start_button:Button = $main_buttons/start_button
@onready var stats_button:Button = $main_buttons/stats_button
@onready var sound_button:Button = $settings_buttons/HBoxContainer/sound_button

var bus_index:int
var is_sound_on = true

# Called when the node enters the scene tree for the first time.
func _ready():
	bus_index = AudioServer.get_bus_index(bus_name)
	start_button.pressed.connect(load_main_level)
	sound_button.pressed.connect(toggle_sound)

func load_main_level():
	get_tree().change_scene_to_file('res://scenes/main.tscn')

func toggle_sound():
	is_sound_on = !is_sound_on
	sound_button.text = 'Sound on' if is_sound_on else 'Sound off'
	AudioServer.set_bus_mute(bus_index, !is_sound_on)
