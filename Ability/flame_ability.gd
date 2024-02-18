extends AbilityProjectile

@onready var life_time_timer = $Timer3
@onready var timer_between_particle = $Timer2

func activate():
	if timer_between_shot.is_stopped():
		$AudioStreamPlayer.play()
		if projectile:
			timer_between_particle.start()
			life_time_timer.start()

func _spawn_bullet():
	var b : Projectile = projectile.instantiate()
	var test_angle = randf_range(-0.5,0.5)
	get_tree().get_root().add_child(b)
	b.global_transform = self.global_transform
	b.rotate(test_angle)
	



func _on_timer_3_timeout():
	timer_between_particle.stop()
	timer_between_shot.start()
