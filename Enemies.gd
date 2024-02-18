extends Node

@export var drop : PackedScene



func _ready():
	for each in get_children():
		if each.has_signal("died"):
			each.died.connect(enemy_died)
			

func enemy_died(value_position):
	var b = drop.instantiate()
	add_child(b)
	b.global_position = value_position


