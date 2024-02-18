extends Ability


@export var speed_change = 2
var changed = []

func _process(_delta):
	$Node2D2.global_rotation = 0

func _on_area_2d_body_entered(body):
	if body.is_in_group("Enemy"):
		changed.append(body)
		body.stats.SPEED = body.stats.SPEED / speed_change
		print(body.stats.SPEED)
		 


func _on_area_2d_body_exited(body):
	if body.is_in_group("Enemy"):
		if changed.has(body):
			changed.remove_at(changed.find(body))
			body.stats.SPEED = body.stats.SPEED * speed_change
