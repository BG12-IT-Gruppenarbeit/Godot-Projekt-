extends Area2D

static var datapaths = preload("res://Weapons/wpn_path.gd")
var data = datapaths.new()
var object

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite2D.texture = data.wpn_paths["pistol"].sprite
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func get_player():
	if is_in_group("Player"):
		return true
