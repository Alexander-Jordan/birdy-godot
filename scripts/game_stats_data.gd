extends Resource
class_name GameStatsData

const point_for_bronze_medal:int = 10
const point_for_silver_medal:int = 25
const point_for_gold_medal:int = 50
const point_for_platinum_medal:int = 100

@export var best_score:int = 0
@export var bronze_first:String = '-'
@export var silver_first:String = '-'
@export var gold_first:String = '-'
@export var platinum_first:String = '-'
@export var bronze_count:int = 0
@export var silver_count:int = 0
@export var gold_count:int = 0
@export var platinum_count:int = 0

func add_medal(medal_index:int):
	if medal_index == 1:
		if bronze_count == 0:
			bronze_first = Time.get_datetime_string_from_system()
		bronze_count += 1
	if medal_index == 2:
		if silver_count == 0:
			silver_first = Time.get_datetime_string_from_system()
		silver_count += 1
	if medal_index == 3:
		if gold_count == 0:
			gold_first = Time.get_datetime_string_from_system()
		gold_count += 1
	if medal_index == 4:
		if platinum_count == 0:
			platinum_first = Time.get_datetime_string_from_system()
		platinum_count += 1
