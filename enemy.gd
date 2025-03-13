extends RigidBody2D


@export var speed = 150.0
@export var attack_range = 20 # Ab hier hört Bewegung auf und angriff beginnt
@export var move_distance = 50 # bewegung pro bewegungsschritt
@export var attack_cooldown = 2.0

var player = null
var moving = false
var attacking = false

@onready var nav_agent = $NavigationAgent2D
@onready var attack_timer = $Timer

func _ready():
	player = get_node("/root/Main/Player")
	attack_timer.wait_time = attack_cooldown
	attack_timer.start()

func _process(delta):
	if player and not attacking:
		var distance = global_position.distance_to(player.global_position)
		
		if distance > attack_range:
			move_towards_player()
		else:
			stop_moving()
			attack()

func move_towards_player():
	if moving or attacking:
		return
	
	moving = true
	var direction = (player.global_position - global_position).normalized()
	var move_target = global_position + direction * move_distance
	nav_agent.target_position = move_target
	
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", move_target, move_distance / float(speed)).set_trans(Tween.TRANS_LINEAR)
	
	tween.finished.connect(func():
		moving = false
	)

func stop_moving():
	moving = false

func attack():
	if attacking:
		return
	
	attacking = true
	stop_moving()
	
	await get_tree().create_timer(0.5).timeout
	if global_position.distance_to(player.global_position) < attack_range:
		#player.take_damage(10)
		pass
	
	attacking = false
