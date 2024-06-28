extends VBoxContainer

@export var bronze_texture:Texture
@export var silver_texture:Texture
@export var gold_texture:Texture
@export var platinum_texture:Texture

@onready var restart_button:TextureButton = $HBoxContainer/restart_button
@onready var menu_button:TextureButton = $HBoxContainer/menu_button
@onready var score_label:Label = $Control/VBoxContainer/score
@onready var medal_texture_rect:TextureRect = $Control/VBoxContainer/medal
@onready var best_score_label:Label = $Control/VBoxContainer/best_score
@onready var audio_stream_player:AudioStreamPlayer = $AudioStreamPlayer

const bronze_medal:int = 10
const silver_medal:int = 25
const gold_medal:int = 50
const platinum_medal:int = 100

func _ready():
	restart_button.pressed.connect(restart_game)
	menu_button.pressed.connect(load_menu)

func restart_game():
	audio_stream_player.play()
	# for now, just reload the current scene
	get_tree().reload_current_scene()

func load_menu():
	audio_stream_player.play()
	# for now, just change to the menu scene
	get_tree().change_scene_to_file('res://scenes/menu.tscn')

func _on_game_manager_game_over(total_score:int, best_score:int):
	score_label.text = 'Score: %s' % str(total_score)
	
	var medal_texture:Texture = Texture.new()
	if total_score >= bronze_medal:
		medal_texture = bronze_texture
	if total_score >= silver_medal:
		medal_texture = silver_texture
	if total_score >= gold_medal:
		medal_texture = gold_texture
	if total_score >= platinum_medal:
		medal_texture = platinum_texture
	medal_texture_rect.texture = medal_texture
	
	best_score_label.text = 'Best: %s' % str(best_score)
	visible = true
