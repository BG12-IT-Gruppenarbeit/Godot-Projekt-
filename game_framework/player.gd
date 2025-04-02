extends CharacterBody2D

class_name Player

var movespeed_base = 150
@export var movespeed = 150
@onready var camera = $Camera2D

var weapon : Weapon
var wpn_paths : = preload("res://Data/data_path.gd")
var wpn = wpn_paths.new()

var held_wpns : Array = ["old_rifle","pistol"]	#array of current weapons | held_wpns[0] is primary and 1 is secondary
var curr_wpn : int = 0		#says if either primary or secondary weapon is out

var hp_max : int = 10		#maximum hp of the player
var hp_curr : int = hp_max		#hp of the player | is full at start

var xp_curr : int = 0		#xp
var xp_max : int = 10		#
var lvl : int = 1			#level increases when xp is full

var dmg_up : float  = 0		#flat dmg change
var dmg_mult : float = 1	#damage multiplier
var firerate : float = 1	#firerate mult
var spread : int = 0		#flat spread change|negative = smaller spread|positive = more spread
var add_bullets : int = 0	#increases base amount of bullets per shot

var lvl_scn : = preload("res://Data/level_up_cards/lvl_pop_up.tscn")		#screen for lvl up

var invincible = false
@export var invincibility_duration = 1.5

func _enter_tree() -> void:
	set_multiplayer_authority(str(name).to_int())

func _ready() -> void:
	equip_weapon(held_wpns[curr_wpn])
	xp_max = pow(lvl * 10,1.3)		#sets xp max to be a function of x * 10 ^1.3
	$Player_hud/XP/MarginContainer/XP_bar.max_value = xp_max	#xp bar datasw
	$Player_hud/XP_text/lvl_num.text = str(lvl)			#sets lvl text at xp  bar
	
	if not is_multiplayer_authority():
		$MeshInstance2D.modulate = Color.RED
		return
	
	$Player_hud.show()
	camera.make_current()
	pass

func _physics_process(delta: float) -> void:
	if not is_multiplayer_authority(): return
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionx := Input.get_axis("ui_left", "ui_right")
	if directionx:
		velocity.x = directionx * movespeed
	else:
		velocity.x = move_toward(velocity.x, 0, movespeed)
		
	var directiony := Input.get_axis("ui_up", "ui_down")
	if directiony:
		velocity.y = directiony * movespeed
	else:
		velocity.y = move_toward(velocity.y, 0, movespeed)
		
	
	
	
	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collision_inst = instance_from_id(collision.get_instance_id())
	look_at(get_global_mouse_position())		#looks at mouse | much wow
	
func _process(delta: float) -> void:
	if not is_multiplayer_authority(): return
	
	if $Shoot_timer.is_stopped():
		if Input.is_action_pressed("shoot"):
			shoot.rpc()  # Schießt mit der aktuellen Waffe
			$Shoot_timer.start((weapon.firerate / (weapon.firerate * weapon.firerate)) / firerate)	#sets a shoot timer so u cant just spam shoot 
		
	if Input.is_action_just_pressed("weapon_swap"):			#swaps primary and secondary weapon
		if curr_wpn == 0:
			curr_wpn = 1
		else :
			curr_wpn = 0
		equip_weapon(held_wpns[curr_wpn])
		
	if Input.is_action_just_pressed("interact"):
		xp_curr = xp_max
		pass
		
	if xp_curr >= xp_max:
		lvl_up()		#lvls up if xp reaches limit
		
	
	if !invincible:
		for i in $Area2D.get_overlapping_bodies():
			if i.is_in_group("Enemy"):
				invincible = true
				take_damage(i.damage)
				$invincibility_timer.start(invincibility_duration)
				$AnimationPlayer.play("invincible")
	
	
func equip_weapon(index : String):
	weapon = wpn.wpn_paths[index]
	$Player_hud/wpn_text.text = wpn.wpn_paths[index].name
	$Player_hud/wpn_sprite.texture = wpn.wpn_paths[index].sprite
	pass

@rpc("any_peer", "call_local")
func shoot():
	weapon.shoot($Firepoint, dmg_up, dmg_mult, spread, add_bullets)
	BulletDefault.set_shooter(self)
	if is_multiplayer_authority():
		hit_enemy.rpc()

@rpc("any_peer", "call_local")
func hit_enemy():
	var enemies_in_range = get_tree().get_nodes_in_group("Enemies")  # Alle Feinde holen, die zur Gruppe "Enemies" gehören
	for enemy in enemies_in_range:
		# Ruf die "hurt"-Methode auf dem Feind per RPC auf
		enemy.hurt.rpc()  # Schaden am Feind anwenden, über RPC an alle Clients

func take_damage(amount : int):		#reduces hp
	change_health(-amount)
	if hp_curr <= 0:
		queue_free()
		
func change_health(change : int):
	hp_curr = clamp(hp_curr + change,0,hp_max)	#changes health
	$Player_hud.update_params()		#updates hp bar
	
func change_max_health(change : int):
	hp_max += change		#changes max health | kinda redundant
	

func lvl_up():
	Engine.time_scale = 0.02		#freezes game
	var xp_excess = xp_curr - xp_max		#makes xp go back to 0 and adds overflow xp
	xp_curr = 0
	lvl += 1		#increases level
	xp_max = pow(lvl * 10,1.3)		#changes xp limit by the funcion lvl*10^1.3
	$Player_hud/XP/MarginContainer/XP_bar.max_value = xp_max	#updates bars
	$Player_hud/XP_text/lvl_num.text = str(lvl)				#updates bar text
	xp_curr = xp_excess		#sets excess xp

	var pop_up = lvl_scn.instantiate()
	add_child(pop_up)	#makes the level up screen appear
	pass
	


func _on_invincibility_timer_timeout() -> void:
	invincible = false
	$AnimationPlayer.play("RESET")
