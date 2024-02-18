extends Node


@export var SPEED : int = 400   # move speed in pixels/sec
@export var MAX_HEALTH : int = 1
@export var HEALTH : int = MAX_HEALTH : set = set_health

var level : int = 1 : set = set_level
var exp_buffer : int = 0
var EXP : int = 0 : set = set_EXP
var MAX_EXP : int = get_max_exp(level)

signal dead
signal Exp_change(value, max_value)
signal level_up
signal health_changed(value, previous_value)

func set_health(value):
	var previous_value = HEALTH
	HEALTH = clamp(value,0,MAX_HEALTH)
	if HEALTH == 0:
		emit_signal("dead")
	emit_signal("health_changed",HEALTH,previous_value)
	
func set_level(value):
	level = value
	MAX_EXP = get_max_exp(level)
	emit_signal("level_up")

func get_max_exp(level):
	return pow((1 +10 ), (level + 1))

func set_EXP(value):
	if value >= MAX_EXP:
		self.level+= 1
		EXP = value - get_max_exp(level-1)
	else:
		EXP =  value
	emit_signal("Exp_change",EXP, MAX_EXP)


func _on_timer_timeout():
	if exp_buffer > 0:
		exp_buffer -= 1
		self.EXP += 1
