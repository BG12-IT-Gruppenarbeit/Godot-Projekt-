extends epic_card


func select():
	player.held_wpns[0] = "minigun"
	player.equip_weapon(player.held_wpns[player.curr_wpn])
