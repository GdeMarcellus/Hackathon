extends Node2D
class_name Projectile

@export var speed = 750

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_Bullet_body_entered(body):
	if body.is_in_group("mobs"):
		body.queue_free()
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()



func _on_life_time_timeout():
	queue_free()
