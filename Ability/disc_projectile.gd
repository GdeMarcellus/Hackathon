extends AbilityProjectile


func activate():
	if timer_between_shot.is_stopped():
		if projectile:
			var amount : int = 1
			var target : int = 10
			var angle_spread = 6.28319/10
			var vector = Vector2.RIGHT * 10
			while amount <= target:
				var b : Projectile = projectile.instantiate()
				get_tree().get_root().add_child(b)
				vector.rotated(angle_spread*amount)
				b.global_transform = (self.global_transform.translated(vector))
				b.rotate(angle_spread*amount)
				amount += 1
				
			timer_between_shot.start()
