extends Node2D

var FCT = preload("res://Asset/DamageLabel.tscn")

@export var travel = Vector2(0, -50)
@export var duration = .3
@export var spread = PI/2

func show_value(value, crit=false):
	var fct = FCT.instantiate()
	add_child(fct)
	fct.show_value(str(value), travel, duration, spread, crit)


func _on_stats_health_changed(value, previous_value):
	print(previous_value)
	if previous_value > value:
		show_value(previous_value - value, false)
