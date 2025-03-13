extends bullet

class_name rocket

@export var explosion : PackedScene = preload("res://particle/Explosion.tscn")	#particle system

var explosion_size : float
@export var damage_explosion = 1

func on_enemy_hit(enemy : Node2D): #reduces the hit enemies hp and then checks for all enemies in an area to reduce all their health
	enemy.hp -= 1
	var explode = explosion.instantiate()
	self.get_tree().current_scene.add_child(explode)
	explode.position = self.global_position
	explode.emitting = true
	for body in $Explosion.get_overlapping_bodies():
		if body.is_in_group("Enemy"):
			body.hp -= damage
			
	queue_free()
	
func on_wall_hit(): #checks for enemies in an area and reduces their health
	var explode = explosion.instantiate() #particle system
	self.get_tree().current_scene.add_child(explode)
	explode.position = self.global_position
	explode.emitting = true
	for body in $Explosion.get_overlapping_bodies():
		if body.is_in_group("Enemy"):
			body.hp -= damage
