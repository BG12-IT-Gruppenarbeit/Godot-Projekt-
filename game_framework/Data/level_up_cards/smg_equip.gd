extends Rare_Card


func select():
	player.held_wpns[0] = "smg"
	player.equip_weapon(player.held_wpns[player.curr_wpn])
