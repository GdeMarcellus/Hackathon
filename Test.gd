extends Node

@onready var gameOver = $GameOver

func _ready():
	gameOver.hide()
	for each : Enemy in $Enemies.get_children():
		each.player = $Player



