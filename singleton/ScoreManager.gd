extends Node


const DEFAULT_SCORE: int = 1000

var _level_scores: Dictionary = {}
var _level_selected: int = 0
var attempts: int = 0
var _cup_hit: int = 0
var _target_cup: int = 0

func _ready():
	SignalManager.on_cup_destroy.connect(on_cup_destroyed)

func check_and_add(level: int):
	if _level_scores.has(level) == false:
		_level_scores[level] = DEFAULT_SCORE
		

func level_selected(level:int):
	check_and_add(level)
	_level_selected = level
	attempts = 0
	_cup_hit = 0
	print("level selected:%s level_score:%s" % [
		_level_selected, _level_scores
	])
	
func get_best_for_level(level:int):
	check_and_add(level)
	return _level_scores[level]
	
func get_attempts():
	return attempts

func get_level_selected():
	return _level_selected
	
func set_target_cups(t:int):
	_target_cup = t
	print("_target_cup: %s" % _target_cup)

func attempt_made():
	attempts +=1
	SignalManager.on_attempt_made.emit()
	print("on_cup-destroyed  _target_cup:%s, attempts;%s, _cup_hit:%s " % [_target_cup, attempts, _cup_hit])

func check_game_over():
	if _cup_hit >= _target_cup:
		print("game over", _level_scores)
		SignalManager.on_game_over.emit()
		if _level_scores[_level_selected] > attempts:
			_level_scores[_level_selected] = attempts
			print("record set:", _level_scores)

func on_cup_destroyed():
	_cup_hit += 1
	print("on_cup-destroyed  _target_cup:%s, attempts;%s, _cup_hit:%s "%[ _target_cup, attempts, _cup_hit])
	check_game_over()
