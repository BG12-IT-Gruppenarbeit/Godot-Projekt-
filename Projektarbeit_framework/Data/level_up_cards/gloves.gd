extends Card




func _on_button_pressed() -> void:
	player.firerate += 0.2
	
	get_parent().get_parent().queue_free()
