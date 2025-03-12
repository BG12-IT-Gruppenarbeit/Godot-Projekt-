@export var wpn_paths = {
	#path of all weapons
	"pistol" : preload("res://Data/Weapons/resources/Pistol.tres"),
	"rifle" : preload("res://Data/Weapons/resources/Rifle.tres"),
	"smg" : preload("res://Data/Weapons/resources/Smg.tres"),
	"rocket" : preload("res://Data/Weapons/resources/Rocket_launcher.tres"),
	"shotgun" : preload("res://Data/Weapons/resources/Shotgun.tres"),
}
@export var card_paths = {
	#paths of all upgrade cards
	rare = {
		
	},
	common = {
		"health candy" = preload("res://Data/level_up_cards/health candy.tscn"),
		"sword" = preload("res://Data/level_up_cards/Sword.tscn"),
		"ruby" = preload("res://Data/level_up_cards/Ruby.tscn"),
		"arrow" = preload("res://Data/level_up_cards/Arrow.tscn"),
		"equip_rifle" = preload("res://Data/level_up_cards/Rifle_equip.tscn"),
		"firerate up" = preload("res://Data/level_up_cards/gloves.tscn") 
	},
}
