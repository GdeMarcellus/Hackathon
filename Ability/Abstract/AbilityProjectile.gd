extends Ability
class_name AbilityProjectile

@export var projectile : PackedScene


func activate():
	if timer_between_shot.is_stopped():
		if projectile:
			var b = projectile.instantiate()
			get_tree().get_root().add_child(b)
			b.global_transform = self.global_transform
			timer_between_shot.start()


