extends CharacterBody2D
class_name Player


@onready var stats = $Stats

var invincibility : bool

@onready var Abillities = $Abillities
@onready var damage_sond = $AudioStreamPlayer

@onready var UI = $UI
@onready var invincible_animation = $AnimationPlayer2

signal died
signal level(value)
func _ready():
	$Sprite2D.texture = Globals.player_texture
	UI.levelupTexture.hide()

func _physics_process(_delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * stats.SPEED

	move_and_slide()

func _process(_delta):
	if Input.is_action_pressed("shoot"):
		for each in Abillities.get_children():
			if each.has_method("activate"):
				each.activate()

func _level_up():
	emit_signal("level", stats.level)
	UI._level_up()
	
func _add_ability(ability : PackedScene):
	var new_ability : Ability = ability.instantiate()
	new_ability.apply_effect(self)
	Abillities.add_child(new_ability)

func _on_stats_dead():
	emit_signal("died")
	queue_free()


func _on_attract_area_entered(area):
	area._attract(self)


func _on_pick_up_area_entered(area):
	if area.has_method("_on_pick_up"):
		area._on_pick_up(self)
		area.queue_free()


func _on_ui_ability_picked(ability):
	_add_ability(ability)


func _on_hurt_box_area_entered(area):
	damage_sond.play()
	stats.HEALTH -= area.damage

func _on_hurt_box_invincibility_started():
	invincible_animation.play("Invincible")


func _on_hurt_box_invincibility_ended():
	invincible_animation.play("Idle")
