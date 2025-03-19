extends RigidBody2D

@export var speed: float = 150.0
@export var health: int = 50  # Mehr Lebenspunkte als andere Gegner
@export var damage: int = 10  # Schaden, den der Gegner verursacht

var player: Node2D = null

func _ready():
	# Sucht den Spieler im Szenenbaum (passen falls nötig)
	player = get_node("/root/Main/Player") if has_node("/root/Main/Player") else null
	freeze_mode = RigidBody2D.FREEZE_MODE_KINEMATIC # Verhindert unkontrolliertes Umfallen

func _process(delta):
	if player:
		move_towards_player()
		

func move_towards_player():
	var direction = (player.global_position - global_position).normalized()
	linear_velocity = direction * speed  # Setzt die Bewegung direkt

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):  
		body.take_damage(damage)  # Der Spieler muss eine "take_damage"-Funktion haben

func take_damage(amount):
	health -= amount
	if health <= 0:
		queue_free()
