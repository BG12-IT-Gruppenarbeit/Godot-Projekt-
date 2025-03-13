@export var wpn_paths = {
	#path of all weapons
	"pistol" : preload("res://Data/Weapons/resources/Pistol.tres"),
	"old_rifle" : preload("res://Data/Weapons/resources/Old_Rifle.tres"),
	"rifle" : preload("res://Data/Weapons/resources/Rifle.tres"),
	"smg" : preload("res://Data/Weapons/resources/Smg.tres"),
	"rocket" : preload("res://Data/Weapons/resources/Rocket_launcher.tres"),
	"shotgun" : preload("res://Data/Weapons/resources/Shotgun.tres"),
	"sniper" : preload("res://Data/Weapons/resources/Sniper.tres"),
	"deagle" : preload("res://Data/Weapons/resources/Deagle.tres"),
	"minigun" : preload("res://Data/Weapons/resources/Minigun.tres"),
}
@export var card_paths = {
	#paths of all upgrade cards
	epic = {
		"equip_minigun" = preload("res://Data/level_up_cards/Minigun_equip.tscn"),
		
	},
	rare = {
		"equip_smg" = preload("res://Data/level_up_cards/Smg_equip.tscn"),
		"bullets_up" = preload("res://Data/level_up_cards/bullets_up.tscn"),
		"boots" = preload("res://Data/level_up_cards/Boots.tscn"),
	},
	common = {
		"health candy" = preload("res://Data/level_up_cards/health candy.tscn"),
		"sword" = preload("res://Data/level_up_cards/Sword.tscn"),
		"ruby" = preload("res://Data/level_up_cards/Ruby.tscn"),
		#"arrow" = preload("res://Data/level_up_cards/Arrow.tscn"),
		"equip_rifle" = preload("res://Data/level_up_cards/Rifle_equip.tscn"),
		"firerate up" = preload("res://Data/level_up_cards/gloves.tscn") 
	},
}
