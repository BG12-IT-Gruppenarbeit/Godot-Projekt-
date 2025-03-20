extends Node2D

@export var enemy_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		var enemy = enemy_scene.instantiate()
		get_parent().add_child(enemy)
		enemy.position = get_global_mouse_position()
		pass
		
