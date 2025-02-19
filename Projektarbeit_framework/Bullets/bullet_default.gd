extends Area2D

class_name bullet

@export var speed = 400
@export var damage_base = 1
var damage_mult = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass

func _physics_process(delta: float) -> void:
	move_local_x(speed * delta)
	


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Walls"):
		on_wall_hit()
	elif body.is_in_group("Enemy"):
		on_enemy_hit(body)
		
func on_enemy_hit(enemy : Node2D):
	enemy.hp -= damage_base * damage_mult
	print(enemy.hp)
	queue_free()

func on_wall_hit():
	queue_free()
