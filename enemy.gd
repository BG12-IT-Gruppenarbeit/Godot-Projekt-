extends CharacterBody2D


@export var speed = 150.0
@export var attack_range = 300 # Ab hier hört Bewegung auf und angriff beginnt
@export var move_distance = 50 # bewegung pro bewegungsschritt
@export var attack_cooldown = 2.0

@export var detection_range = 300 

var player = null
var moving = false

@onready var nav_agent = $NavigationAgent2D

func _ready():
	player = get_node("/root/Main/Player")
	nav_agent.target_position = global_position

func _process(delta):
	if player:
		var distance = global_position.distance_to(player.global_position)
		if distance < detection_range:
			nav_agent.target_position = player.global_position

func _physics_process(delta):
	if nav_agent.is_navigation_finished():
		return
	var next_path_position = nav_agent.get_next_path_position()
	var direction = (next_path_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()
