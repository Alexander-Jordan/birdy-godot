extends Node

var base_path = 'user://save/'

func _ready():
	DirAccess.make_dir_absolute(base_path)

func persist_nodes(load:bool = false):
	var persist_nodes = get_tree().get_nodes_in_group('persist')
	var persist_function_name:String = 'load_data' if load == true else 'save_data'
	
	for node in persist_nodes:
		if !node.has_method(persist_function_name):
			print('persistent node "' + node.name + '" is missing a ' + persist_function_name + ' function, skipped')
			continue
		
		node.call(persist_function_name, base_path)

func save_persisted_nodes():
	persist_nodes()

func load_persisted_nodes():
	persist_nodes(true)
