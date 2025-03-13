extends CanvasLayer

var data_paths : = preload("res://Data/data_path.gd")
var data = data_paths.new()

var items : int = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var used_cards : Array = [0,0,0]
	for slots in items :		#gets 3 random cards from the dictionary to pick
		var rarity = (randi()%100) + 1
		var random_key
		if rarity >= 99 :	#epic cards (1%)
			random_key = data.card_paths.epic.keys().pick_random()
			while used_cards.has(random_key) :
				random_key = data.card_paths.epic.keys().pick_random()
			used_cards[slots] = random_key
			var card = data.card_paths.epic[random_key].instantiate()
			$HBoxContainer.add_child(card)
		elif rarity >= 90 :		#rare cards (9%)
			random_key = data.card_paths.rare.keys().pick_random()
			while used_cards.has(random_key) :
				random_key = data.card_paths.rare.keys().pick_random()
			used_cards[slots] = random_key
			var card = data.card_paths.rare[random_key].instantiate()
			$HBoxContainer.add_child(card)
		else :
			random_key = data.card_paths.common.keys().pick_random()	#gets a random card from the given card pool
			while used_cards.has(random_key) :
				random_key = data.card_paths.common.keys().pick_random()	#makes sure that there are no repeating cards
			used_cards[slots] = random_key							#adds the card to the already picked cards so that no dupes are there
			var card = data.card_paths.common[random_key].instantiate()		#instantiates card
			$HBoxContainer.add_child(card)				#adds card as child to hboxcontainer
	used_cards.clear


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
