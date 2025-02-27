extends CanvasLayer

@onready var player = self.get_parent()

var HP_size : int = 4


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HP.size.x = player.hp_max * HP_size + 2
	update_params()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func change_health(change : int):
	player.hp_curr = clamp(player.hp_curr + change,0,player.hp_max)
	update_params()
	
func change_max_health(change : int):
	player.hp_max += change
	$HP.size.x = player.hp_max * HP_size + 2
	update_params()

func update_params():
	$HP/MarginContainer/HP_bar.max_value = player.hp_max
	$HP/MarginContainer/HP_bar.value = player.hp_curr
	$HBoxContainer/hp_max.text = str(player.hp_max)
	$HBoxContainer/hp_curr.text = str(player.hp_curr)
