extends RigidBody2D

class_name Enemy

@export var hp_max : int
@onready var hp : int = hp_max
@export var damage : int = 1
@export var xp = 0	#jeder gegner hat seine eigenen xp die er beim tot gibt

var players : Array


func _ready() -> void:
	players = get_tree().get_nodes_in_group("Player")	#es werden alle spieler in einem array gesammelt
	#$CollisionShape2D/ProgressBar.max_value = hp_max


func _process(delta: float) -> void:
	if hp <= 0:
		for player in players:			#alle spieler kriegen xp
			player.xp_curr += xp
		queue_free()
	if hp < hp_max:
		#$CollisionShape2D/ProgressBar.visible = true
		pass
	#$dCollisionShape2D/ProgressBar.value = hp
	
	
func hurt():
	$AnimationPlayer.stop(true)
	$AnimationPlayer.play("enemy_hurt")
	
