extends bullet

class_name rocket

@export var explosion : PackedScene = preload("res://particle/Explosion.tscn")

var explosion_size : float
@export var damage_explosion = 1

func on_enemy_hit(enemy : Node2D):
	enemy.hp -= 1
	var explode = explosion.instantiate()
	self.get_tree().current_scene.add_child(explode)
	explode.position = self.global_position
	explode.emitting = true
	for body in $Explosion.get_overlapping_bodies():
		if body.is_in_group("Enemy"):
			body.hp -= damage_base * damage_mult
			
	queue_free()
	
func on_wall_hit():
	var explode = explosion.instantiate()
	self.get_tree().current_scene.add_child(explode)
	explode.position = self.global_position
	explode.emitting = true
	for body in $Explosion.get_overlapping_bodies():
		if body.is_in_group("Enemy"):
			body.hp -= damage_explosion * damage_mult
