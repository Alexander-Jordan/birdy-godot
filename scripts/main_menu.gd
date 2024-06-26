extends VBoxContainer

@onready var start_button:Button = $main_buttons/start_button
@onready var stats_button:Button = $main_buttons/stats_button
@onready var sfx_button:Button = $settings_buttons/HBoxContainer/sfx_button
@onready var music_button:Button = $settings_buttons/HBoxContainer/music_button

var sfx_bus_index:int
var music_bus_index:int
var is_music_on = false
var is_sfx_on = true

# Called when the node enters the scene tree for the first time.
func _ready():
	music_bus_index = AudioServer.get_bus_index('music')
	sfx_bus_index = AudioServer.get_bus_index('sfx')
	
	is_music_on = SaveSystem.settings_data.audio.music
	is_sfx_on = SaveSystem.settings_data.audio.sfx
	set_music()
	set_sfx()
	
	start_button.pressed.connect(load_main_level)
	music_button.pressed.connect(toggle_music)
	sfx_button.pressed.connect(toggle_sfx)

func load_main_level():
	get_tree().change_scene_to_file('res://scenes/main.tscn')

func set_music():
	music_button.text = 'Music on' if is_music_on else 'Music off'
	AudioServer.set_bus_mute(music_bus_index, !is_music_on)

func set_sfx():
	sfx_button.text = 'SFX on' if is_sfx_on else 'SFX off'
	AudioServer.set_bus_mute(sfx_bus_index, !is_sfx_on)

func toggle_music():
	is_music_on = !is_music_on
	set_music()
	
	SaveSystem.settings_data.audio.music = is_music_on
	SaveSystem.save_settings()

func toggle_sfx():
	is_sfx_on = !is_sfx_on
	set_sfx()
	
	SaveSystem.settings_data.audio.sfx = is_sfx_on
	SaveSystem.save_settings()
