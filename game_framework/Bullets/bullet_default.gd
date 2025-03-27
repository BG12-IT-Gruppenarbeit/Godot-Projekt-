extends Area2D

class_name bullet

@export var speed = 400
@export var damage = 1

var shooter : Node = null  # Der Spieler, der die Bullet abgefeuert hat

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Stelle sicher, dass der Bullet in einer Gruppe von "Bullets" ist, falls nötig
	add_to_group("Bullets")
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	move_local_x(speed * delta)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Walls"):
		on_wall_hit()
	elif body.is_in_group("Enemy"):
		on_enemy_hit(body)

# Handles what happens when the bullet collides with an enemy
@rpc("any_peer")
func on_enemy_hit(enemy : Node2D):
	if enemy is Enemy:  # Sicherstellen, dass es sich wirklich um ein Enemy handelt
		enemy.hurt()  # Schaden am Feind anwendenw
		remove_bullet.rpc()
		remove_bullet()  # Bullet nach dem Treffer zerstören

# Handles what happens when the bullet collides with a wall
@rpc("any_peer")
func on_wall_hit():
	remove_bullet.rpc()
	remove_bullet()  # Bullet nach Kollision mit der Wand zerstören

# Removes the bullet (called from other functions via RPC)
@rpc("any_peer")
func remove_bullet() -> void:
	queue_free()  # Bullet auf allen Clients zerstören

func set_shooter(player : Node):
	shooter = player  # Weist der Bullet den Spieler zu, der sie abgefeuert hat

func _on_timer_timeout() -> void:
	queue_free()
