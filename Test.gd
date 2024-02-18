extends Node

var simultaneous_scene = preload("res://Menu/mainMenu.tscn").instantiate()

@onready var gameOver = $GameOver
@onready var audio_level_1 = $AudioLevel1
@onready var audio_level_2 = $AudioLevel2
@onready var audio_level_3 = $AudioLevel3
@onready var audio_level_4 = $AudioLevel4
@onready var audio_level_5 = $AudioLevel5
@onready var button_audio = $ButtonAudio

@onready var animation = $AnimationPlayer

@export var enemies : Array[PackedScene]


var wait_time : float = 0.75

func _ready():
	gameOver.visible = false
	audio_level_1.play()
	for each : Enemy in $Enemies.get_children():
		each.player = $Player


func _on_mob_timer_timeout():
	# Create a new instance of the Mob scene.
	var player =  $Player
	if player:
		enemies.shuffle()
		var mob = enemies.front().instantiate()
	
	
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
		mob.died.connect($Enemies.enemy_died)
		wait_time -= 0.001
		$mobTimer.start(wait_time)


func _on_player_died():
	get_tree().paused = true
	$Camera2D.make_current()
	$GameOver.visible = true


func _on_player_level(value):
	if value >= 8:
		audio_level_1.stop()
		audio_level_2.stop()
		audio_level_3.stop()
		audio_level_4.stop()
		audio_level_5.play()
	elif value >= 6:
		audio_level_1.stop()
		audio_level_2.stop()
		audio_level_3.stop()
		audio_level_4.play()
		audio_level_5.stop()
	elif value >= 4:
		audio_level_1.stop()
		audio_level_2.stop()
		audio_level_3.play()
		audio_level_4.stop()
		audio_level_5.stop()
	elif value >= 2:
		audio_level_1.stop()
		audio_level_2.play()
		audio_level_3.stop()
		audio_level_4.stop()
		audio_level_5.stop()
	


func _on_button_pressed():
	animation.play("FadeOut")
	await animation.animation_finished
	gameOver.visible = false
	get_tree().change_scene_to_file("res://Menu/mainMenu.tscn")
