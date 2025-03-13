extends Card


func select():
	player.held_wpns[0] = "rifle"
	player.equip_weapon(player.held_wpns[player.curr_wpn])
