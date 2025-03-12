extends CharacterBody2D


@export var speed = 50.0
@export var attack_range = 300
@export var move_distance = 50
@export var attack_cooldown = 2.0

var player = null
var moving = false

@onready var nav_agent = $NavigationAgent2D
@onready var attack_timer = $Timer
@onready var projectile_spawn = $Marker2D

func _ready():
	player = get_node("/root/Main/Player")
	attack_timer.wait_time = attack_cooldown
	attack_timer.start()

func _process(delta):
	if player:
		var distance = global_position.distance_to(player.global_position)
		
		if distance > attack_range:
			move_towards_player()
		else:
			stop_moving()

func move_towards_player():
	if moving:
		return
	
	moving = true
	var direction = (player.global_position - global_position).normalized()
	var move_target = global_position +direction * move_distance
	nav_agent.target_position = move_target
	
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", move_target, move_distance / speed).set_trans(Tween.TRANS_LINEAR)
	
	tween.finished.connect(func():
		moving = false
		)

func stop_moving():
	moving = false

func _on_Timer_timeout():
	if player == null:
		return
	
	var attack_type = randi_range(1, 3)
	
	if attack_type == 1:
		shoot_projectile(200, 5)
	elif attack_type == 2:
		shoot_projectile(200, 5)
	elif attack_type == 3:
		shoot_projectile(100, 15)

func shoot_projectile(proj_speed, damage):
	var projectile = preload("res://projectile.tscn").instantiate()
	projectile.position = projectile_spawn.global_position
	projectile.target = player.global_position
	projectile.speed = proj_speed
	projectile.damage = damage
	get_tree().current_scene.add_child(projectile)
