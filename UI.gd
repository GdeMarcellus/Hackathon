extends CanvasLayer

@onready var levelupTexture = $Control/PopupMenu
@onready var Levelup = $Control/PopupMenu
@onready var availableAbility = $AvailableAbility

signal ability_picked(ability)


func _on_stats_exp_change(value, max_exp):
	$Control/EXPBar.value = value
	$Control/EXPBar.max_value = max_exp


func _on_popup_menu_popup_hide():
	get_tree().paused = false

func _level_up():
	Levelup.clear()
	var amount = 1
	var choices = availableAbility.avaiable_ability.duplicate()
	while amount <= 2:
		if !(choices.is_empty()):
			choices.shuffle()
			var choice : PackedScene = (choices.pop_front())
			var temp : Ability = choice.instantiate()
			Levelup.add_item(temp.ability_name, temp.icon, true)
			Levelup.set_item_metadata(amount-1,choice)
			Levelup.set_item_tooltip(amount-1, temp.ability_descrtiption)
			
			temp.queue_free()
		amount += 1
	levelupTexture.show()
	get_tree().paused = true



func _on_popup_menu_item_selected(index):
	var temp = Levelup.get_item_metadata(index)
	availableAbility.avaiable_ability.erase(temp)
	_add_ability(temp)
	emit_signal("ability_picked", temp)
	levelupTexture.hide()

func _add_ability(temp):
	var icon_display = $Control/Icondisplay
	for each in icon_display.get_children():
		if each.is_in_group("TextureIcon"):
			if each.texture == null:
				var temp_scene = temp.instantiate()
				each.texture = temp_scene.icon
				temp_scene.queue_free()
				return


func _on_popup_menu_visibility_changed():
	$Control/Panel.visible = !$Control/Panel.visible


func _on_stats_health_changed(value, _previous_value):
	$Control/Health.value = value
