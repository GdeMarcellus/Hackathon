extends Node2D
class_name Ability

@export var ability_name : String
@export_multiline  var ability_descrtiption
@export var icon : Texture2D

@onready var timer_between_shot = $Timer

@export var delay : float = 0.1 : set = delay_changed 


# Called when the node enters the scene tree for the first time.
func _ready():
	timer_between_shot.wait_time = delay

func delay_changed(value):
	delay = clamp(value,0,100)
	if timer_between_shot:
		timer_between_shot.wait_time = delay

func apply_effect(player : Player):
	pass
