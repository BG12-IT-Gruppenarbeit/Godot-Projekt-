extends Rare_Card


func select():
	player.held_wpns[1] = "deagle"
	player.equip_weapon(player.held_wpns[player.curr_wpn])
