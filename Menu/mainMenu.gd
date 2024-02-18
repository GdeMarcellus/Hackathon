extends Control

var simultaneous_scene = preload("res://Test.tscn").instantiate()

@onready var fadeout = $AnimationPlayer

@export var textures : Array[Texture2D]
var current : int = 0 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_play_button_pressed():
	fadeout.play("FadeOut")


func _on_animation_player_animation_finished(anim_name):
	get_tree().root.add_child(simultaneous_scene)
	get_node("/root/MainMenu").queue_free()


func _on_next_Skin_button_pressed():
	if current < textures.size() -1:
		current += 1
		$Panel/Sprite2D.texture = textures[current]
		Globals.player_texture = textures[current]
	else:
		current = -1
