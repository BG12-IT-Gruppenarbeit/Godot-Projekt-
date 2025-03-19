extends CharacterBody2D

@export var speed: float = 80
@export var attack_range: float = 300
@export var detection_range: float = 500
@export var attack_cooldown: float = 2.0

var player = null
var can_attack = true

@onready var navigation_agent = $NavigationAgent2D

func _ready():
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0

func _process(delta):
	if player:
		var distance = global_position.distance_to(player.global_position)
		
		if distance < detection_range:
			navigation_agent.target_position = player.global_position
			move_towards_target(delta, distance)
		
		if distance < attack_range and can_attack:
			attack()

func move_towards_target(delta, distance):
	if distance > attack_range:  # Bewegt sich nur, wenn außerhalb der Angriffsdistanz
		var next_position = navigation_agent.get_next_path_position()
		var direction = (next_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
	
func attack():
	can_attack = false
	var attack_type = randi() % 3
	if attack_type < 2:
		print("Schneller Fernangriff")
	else:
		print("Starker Fernangriff")

	await get_tree().create_timer(attack_cooldown).timeout
	can_attack = true
