extends Area2D

var player : Player

@export var speed = 2600

var velocity = Vector2.ZERO
var acceleration = Vector2.ZERO

@onready var softCollision = $SoftColision

func _process(delta):
	if player:
		velocity = global_position.direction_to(player.global_position) * speed * delta
		if softCollision.is_colliding():
			velocity += softCollision.get_push_vector() * delta * 200
		global_position += velocity * delta

		
func _attract(target : Player):
	player = target
	
func _on_pick_up(target : Player):
	target.stats.exp_buffer += 10


