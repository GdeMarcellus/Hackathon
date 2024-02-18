extends Label

func show_value(value, travel, duration, spread, crit=false):
	text = value
	var movement = travel.rotated(randf_range(-spread/2, spread/2))
	pivot_offset = size / 10
	
	
	var tween = get_tree().create_tween()
	
	tween.tween_property(self, "position", position + movement,duration)
	tween.tween_property(self, "modulate", Color(Color.RED, 0.0), duration)

		
	tween.play()
	await tween.finished
	queue_free()
