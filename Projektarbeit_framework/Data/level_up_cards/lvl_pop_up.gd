extends CanvasLayer

var data_paths : = preload("res://Data/data_path.gd")
var data = data_paths.new()

var items : int = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var used_cards : Array
	for slots in items :		#gets 3 random cards from the dictionary to pick
		var random_key = data.card_paths.common.keys().pick_random()
		while used_cards.has(random_key) :
			random_key = data.card_paths.common.keys().pick_random()
		print(data.card_paths.common[random_key])
		var card = data.card_paths.common[random_key].instantiate()
		$HBoxContainer.add_child(card)
		pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
