extends PopupPanel

@onready var games_label:Label = $MarginContainer/VBoxContainer/games/value
@onready var last_score_label:Label = $MarginContainer/VBoxContainer/last_score/value
@onready var best_score_label:Label = $MarginContainer/VBoxContainer/best_score/value
@onready var bronze_first_label:Label = $MarginContainer/VBoxContainer/bronze/VBoxContainer/first/value
@onready var bronze_count_label:Label = $MarginContainer/VBoxContainer/bronze/VBoxContainer/count/value
@onready var silver_first_label:Label = $MarginContainer/VBoxContainer/silver/VBoxContainer/first/value
@onready var silver_count_label:Label = $MarginContainer/VBoxContainer/silver/VBoxContainer/count/value
@onready var gold_first_label:Label = $MarginContainer/VBoxContainer/gold/VBoxContainer/first/value
@onready var gold_count_label:Label = $MarginContainer/VBoxContainer/gold/VBoxContainer/count/value
@onready var platinum_first_label:Label = $MarginContainer/VBoxContainer/platinum/VBoxContainer/first/value
@onready var platinum_count_label:Label = $MarginContainer/VBoxContainer/platinum/VBoxContainer/count/value
@onready var flaps_label:Label = $MarginContainer/VBoxContainer/flaps/value
@onready var pipes_passed_label:Label = $MarginContainer/VBoxContainer/pipes_passed/value
@onready var deaths_with_zero_points_label:Label = $MarginContainer/VBoxContainer/deaths_with_zero_points/value

func _ready():
	games_label.text = str(SaveSystem.game_stats_data.games_count)
	last_score_label.text = str(SaveSystem.game_stats_data.last_score)
	best_score_label.text = str(SaveSystem.game_stats_data.best_score)
	bronze_first_label.text = SaveSystem.game_stats_data.bronze_first
	bronze_count_label.text = str(SaveSystem.game_stats_data.bronze_count)
	silver_first_label.text = SaveSystem.game_stats_data.silver_first
	silver_count_label.text = str(SaveSystem.game_stats_data.silver_count)
	gold_first_label.text = SaveSystem.game_stats_data.gold_first
	gold_count_label.text = str(SaveSystem.game_stats_data.gold_count)
	platinum_first_label.text = SaveSystem.game_stats_data.platinum_first
	platinum_count_label.text = str(SaveSystem.game_stats_data.platinum_count)
	flaps_label.text = str(SaveSystem.game_stats_data.flaps)
	pipes_passed_label.text = str(SaveSystem.game_stats_data.pipes_passed)
	deaths_with_zero_points_label.text = str(SaveSystem.game_stats_data.deaths_with_zero_points)
