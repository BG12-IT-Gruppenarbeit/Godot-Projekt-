extends "res://Data/level_up_cards/card_default.gd"


func _on_button_pressed() -> void:
	player.spread -= 10
	
	get_parent().get_parent().queue_free()
