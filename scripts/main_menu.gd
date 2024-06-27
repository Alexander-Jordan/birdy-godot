extends VBoxContainer

@onready var start_button:TextureButton = $main_buttons/start_button
@onready var stats_button:TextureButton = $main_buttons/stats_button
@onready var sfx_button:TextureButton = $settings_buttons/HBoxContainer/sfx_button
@onready var music_button:TextureButton = $settings_buttons/HBoxContainer/music_button
@onready var audio_stream_player:AudioStreamPlayer = $AudioStreamPlayer

var sfx_bus_index:int
var music_bus_index:int

# Called when the node enters the scene tree for the first time.
func _ready():
	music_bus_index = AudioServer.get_bus_index('music')
	sfx_bus_index = AudioServer.get_bus_index('sfx')
	AudioServer.set_bus_mute(music_bus_index, !SaveSystem.settings_data.audio.music)
	AudioServer.set_bus_mute(sfx_bus_index, !SaveSystem.settings_data.audio.sfx)
	
	start_button.pressed.connect(load_main_level)
	music_button.toggled.connect(toggle_music)
	sfx_button.toggled.connect(toggle_sfx)
	
	music_button.set_pressed_no_signal(!SaveSystem.settings_data.audio.music)
	sfx_button.set_pressed_no_signal(!SaveSystem.settings_data.audio.sfx)

func load_main_level():
	audio_stream_player.play()
	get_tree().change_scene_to_file('res://scenes/main.tscn')

func toggle_music(is_off:bool):
	audio_stream_player.play()
	AudioServer.set_bus_mute(music_bus_index, is_off)
	SaveSystem.settings_data.audio.music = !is_off
	SaveSystem.save_settings()

func toggle_sfx(is_off:bool):
	audio_stream_player.play()
	AudioServer.set_bus_mute(sfx_bus_index, is_off)
	SaveSystem.settings_data.audio.sfx = !is_off
	SaveSystem.save_settings()
