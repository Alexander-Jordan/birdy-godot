extends Resource
class_name GameStatsData

const point_for_bronze_medal:int = 10
const point_for_silver_medal:int = 25
const point_for_gold_medal:int = 50
const point_for_platinum_medal:int = 100

@export var games_count:int = 0
@export var flaps:int = 0
@export var deaths_with_zero_points:int = 0
@export var pipes_passed:int = 0
@export var last_score:int = 0 :
	set(value):
		last_score = value
		set_last_medal()
		# is it a new best score?
		if self.last_score > self.best_score:
			self.best_score = self.last_score
@export var last_medal:int = 0
@export var best_score:int = 0
@export var bronze_first:String = '-'
@export var silver_first:String = '-'
@export var gold_first:String = '-'
@export var platinum_first:String = '-'
@export var bronze_count:int = 0
@export var silver_count:int = 0
@export var gold_count:int = 0
@export var platinum_count:int = 0

func set_last_medal():
	if (self.last_score >= self.point_for_bronze_medal) and (self.last_score < self.point_for_silver_medal):
		self.last_medal = 1
	elif (self.last_score >= self.point_for_silver_medal) and (self.last_score < self.point_for_gold_medal):
		self.last_medal = 2
	elif (self.last_score >= self.point_for_gold_medal) and (self.last_score < self.point_for_platinum_medal):
		self.last_medal = 3
	elif self.last_score >= self.point_for_platinum_medal:
		self.last_medal = 4
	else:
		self.last_medal = 0

func add_medal():
	if self.last_medal == 1:
		if bronze_count == 0:
			bronze_first = Time.get_date_string_from_system()
		bronze_count += 1
	if self.last_medal == 2:
		if silver_count == 0:
			silver_first = Time.get_date_string_from_system()
		silver_count += 1
	if self.last_medal == 3:
		if gold_count == 0:
			gold_first = Time.get_date_string_from_system()
		gold_count += 1
	if self.last_medal == 4:
		if platinum_count == 0:
			platinum_first = Time.get_date_string_from_system()
		platinum_count += 1
	# set last medal to none after adding the medal
	self.last_medal = 0
