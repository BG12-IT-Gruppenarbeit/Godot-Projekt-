extends Resource

class_name Weapon

@export var damage : float
@export var firerate : float
@export var spread : int
@export var blt_speed : int = 200
@export var blt_amt : int = 1
@export var name : String

@export var bullet : PackedScene
@export var sprite : AtlasTexture

func shoot(Firepoint : Node2D, dmg_up : int, dmg_mult : float, spread_change) :
	for shots in blt_amt :
		var b = bullet.instantiate()
		Firepoint.get_tree().current_scene.add_child(b)		#shoots a bullet from a preset point
		b.position = Firepoint.global_position
		b.rotation = Firepoint.global_rotation + deg_to_rad(randf_range(-0.5 * clamp(spread + spread_change, 0, INF), 0.5 * clamp(spread + spread_change, 0, INF)))
		#makes the rotation be a bit random depending on the set spread of the weapon and the modifier of the player
		b.speed = blt_speed
		b.damage = (damage + dmg_up) * dmg_mult
