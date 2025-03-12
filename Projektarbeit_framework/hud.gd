extends CanvasLayer

@onready var player = self.get_parent()

var HP_size : int = 2		#sets the relative size of the bar per max health point



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HP.size.x = player.hp_max * HP_size + 2		#increases in size as the max_hp gets higher
	update_params()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$XP/MarginContainer/XP_bar.value = player.xp_curr		#updates xp bar
	pass
	
	update_params()

func update_params():		#updates all the text and value data for the bars
	$HP/MarginContainer/HP_bar.max_value = player.hp_max
	$HP/MarginContainer/HP_bar.value = player.hp_curr
	$HBoxContainer/hp_max.text = str(player.hp_max)
	$HBoxContainer/hp_curr.text = str(player.hp_curr)
	$HP.size.x = player.hp_max * HP_size + 2

func set_xp(amt : int):		#sets the xp amount for the bar
	$XP/MarginContainer/XP_bar.value = amt
	pass
