extends Card





func _on_button_pressed() -> void:
	player.held_wpns[0] = "rifle"
	player.equip_weapon(player.held_wpns[player.curr_wpn])
	get_parent().get_parent().queue_free()
