extends Node

@onready var gameOver = $GameOver
@export var enemies : Array[PackedScene]

func _ready():
	gameOver.hide()
	for each : Enemy in $Enemies.get_children():
		each.player = $Player


func _on_mob_timer_timeout():
	# Create a new instance of the Mob scene.
	enemies.shuffle()
	var mob = enemies.front().instantiate()
	var player =  $Player
	
	var randomAngle = randf() * 2 * PI
	var vector_length = player.global_position + Vector2(get_viewport().size.x,0)
	# Choose a random location on Path2D.
	var mob_spawn_location = vector_length.rotated(randomAngle)
	# Set the mob's position to a random location.a
	mob.position = mob_spawn_location
	
	mob.player = $Player
	# Choose the velocity for the mob.
	
	
	# Spawn the mob by adding it to the Main scene.
	$Enemies.add_child(mob)
