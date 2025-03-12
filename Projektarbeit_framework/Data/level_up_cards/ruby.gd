extends "res://Data/level_up_cards/card_default.gd"

func _on_button_pressed() -> void:
	player.dmg_mult += 0.5
	
	get_parent().get_parent().queue_free()
