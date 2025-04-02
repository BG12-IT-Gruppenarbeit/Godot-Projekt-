extends RigidBody2D

class_name Enemy

@export var hp_max : int
@onready var hp : int = hp_max
@export var damage : int = 1
@export var xp = 1	#jeder gegner hat seine eigenen xp die er beim tot gibt

var last_hit_player : Player = null  # Den Spieler speichern, der den letzten Treffer ausführt

var players : Array

func _ready() -> void:
	players = get_tree().get_nodes_in_group("Player")	#es werden alle spieler in einem array gesammelt
	#$CollisionShape2D/ProgressBar.max_value = hp_max


#func _process(delta: float) -> void:
	#if hp <= 0:
		#for player in players:			#alle spieler kriegen xp
			#player.xp_curr += xp
		#die()
	#if hp < hp_max:
		##$CollisionShape2D/ProgressBar.visible = true
		#pass
	##$dCollisionShape2D/ProgressBar.value = hp
	

@rpc("any_peer", "call_local")
func hurt():
	$AnimationPlayer.stop(true)
	$AnimationPlayer.play("enemy_hurt")
	
	hp -= damage  # Reduziere den HP-Wert des Feindes um den Schaden
	
	if hp <= 0:  # Wenn der Feind keine HP mehr hat, stirbt er
		for player in players:			#alle spieler kriegen xp
			player.xp_curr += xp
		die()

func die():
	queue_free()
