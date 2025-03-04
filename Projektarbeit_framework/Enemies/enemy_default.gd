extends RigidBody2D

class_name Enemy

@export var hp_max : int
@onready var hp : int = hp_max


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Enemy_healthbar.visible =  false
	$Enemy_healthbar.max_value = hp
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if hp <= 0:
		queue_free()
	if hp < hp_max:
		$Enemy_healthbar.visible = true
	
	
	$Enemy_healthbar.value = hp
