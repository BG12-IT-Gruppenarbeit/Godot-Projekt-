extends "res://Data/level_up_cards/card_default.gd"


func _on_button_pressed():
	player.hp_max += 2
	player.hp_curr += 2
	get_parent().get_parent().queue_free()
