extends Node

const SAVE_FOLDER_PATH = 'user://save/'
const SAVE_FILE_NAME = 'game_stats_data.tres'
const SETTINGS_FILE_PATH = 'user://SETTINGS.cfg'

const SETTINGS_DEFAULT:Dictionary = {
	'audio': {
		'master': true,
		'music': false,
		'sfx': true,
	}
}

var game_stats_data:GameStatsData = GameStatsData.new()
var settings_data:Dictionary = {}

func _ready():
	if !DirAccess.dir_exists_absolute(SAVE_FOLDER_PATH):
		DirAccess.make_dir_absolute(SAVE_FOLDER_PATH)
	load_data()
	load_settings()

func _notification(what):
	# make sure to always save before closing down the game
	# NOTIFICATION_WM_GO_BACK_REQUEST is used for an android back-button
	if what == NOTIFICATION_WM_CLOSE_REQUEST or what == NOTIFICATION_WM_GO_BACK_REQUEST:
		save_data()
		get_tree().quit()

func save_data():
	game_stats_data.add_medal()
	ResourceSaver.save(game_stats_data, SAVE_FOLDER_PATH + SAVE_FILE_NAME)

func load_data():
	if ResourceLoader.exists(SAVE_FOLDER_PATH + SAVE_FILE_NAME):
		game_stats_data = ResourceLoader.load(SAVE_FOLDER_PATH + SAVE_FILE_NAME).duplicate(true)

func load_settings():
	# create new ConfigFile object
	var config = ConfigFile.new()
	# load in existing settings from file
	var error = config.load(SETTINGS_FILE_PATH)
	
	# if no file
	if error != OK:
		# get default data from constant
		settings_data = SETTINGS_DEFAULT.duplicate(true)
		# save and return
		save_settings()
		return
	
	# set data from config file
	for config_section in config.get_sections():
		settings_data[config_section] = {}
		for config_section_key in config.get_section_keys(config_section):
			settings_data[config_section][config_section_key] = config.get_value(config_section, config_section_key)

func save_settings():
	# create new ConfigFile object
	var config = ConfigFile.new()
	
	for config_section in settings_data:
		for config_section_key in settings_data[config_section]:
			config.set_value(config_section, config_section_key, settings_data[config_section][config_section_key])
	
	# finally save to file
	config.save(SETTINGS_FILE_PATH)
