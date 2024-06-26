extends Node

const SAVE_FOLDER_PATH = 'user://save/'
const SETTINGS_FILE_PATH = 'user://SETTINGS.cfg'

const SETTINGS_DEFAULT:Dictionary = {
	'audio': {
		'master': true,
		'music': true,
		'sfx': true,
	}
}

var settings_data:Dictionary = {}

func _ready():
	load_settings()
	DirAccess.make_dir_absolute(SAVE_FOLDER_PATH)

func persist_nodes(should_load:bool = false):
	var nodes = get_tree().get_nodes_in_group('persist')
	var persist_function_name:String = 'load_data' if should_load else 'save_data'
	
	for node in nodes:
		if !node.has_method(persist_function_name):
			print('persistent node "' + node.name + '" is missing a ' + persist_function_name + ' function, skipped')
			continue
		
		node.call(persist_function_name, SAVE_FOLDER_PATH)

func save_persisted_nodes():
	persist_nodes()

func load_persisted_nodes():
	persist_nodes(true)

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
	
	print(settings_data)
