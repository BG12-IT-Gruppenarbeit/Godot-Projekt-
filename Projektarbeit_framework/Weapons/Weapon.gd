extends Resource

class_name Weapon

@export var damage : float
@export var firerate : float
@export var spread : int
@export var blt_speed : int = 200
@export var name : String

@export var bullet : PackedScene
@export var sprite : Texture2D

func shoot(Firepoint : Node2D) :
	var b = bullet.instantiate()
	Firepoint.get_tree().current_scene.add_child(b)
	b.position = Firepoint.global_position
	b.rotation = Firepoint.global_rotation + deg_to_rad(randf_range(-0.5 * spread, 0.5 * spread))
	b.speed = blt_speed
	pass
