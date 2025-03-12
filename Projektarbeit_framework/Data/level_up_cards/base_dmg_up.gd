extends "res://Data/level_up_cards/card_default.gd"

func _on_button_pressed() -> void:
	player.dmg_up += 0.3
	
	get_parent().get_parent().queue_free()
