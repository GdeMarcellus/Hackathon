extends CharacterBody2D
class_name Enemy

var player = null


@onready var stats = $Stats
@onready var invincible_animation = $AnimationPlayer2
@onready var hurtBox = $HurtBox

@export var drop : PackedScene


func _physics_process(delta):
	velocity = Vector2.ZERO
	if player != null:
		velocity = position.direction_to(player.position) * stats.SPEED
	move_and_slide()

func _on_DetectRadius_body_entered(body):
	player = body

func _on_DetectRadius_body_exited(body):
	player = null

func _player_change():
	pass


func _on_hurt_box_area_entered(area):
	stats.HEALTH -= area.damage


func _on_stats_dead():
	if drop:
		var b = drop.instantiate()
		get_tree().get_root().add_child(b)
		b.global_transform = self.global_transform
	queue_free()


func _on_hurt_box_invincibility_started():
	invincible_animation.play("Invincible")


func _on_hurt_box_invincibility_ended():
	invincible_animation.play("Idle")
