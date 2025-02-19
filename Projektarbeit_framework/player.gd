extends CharacterBody2D



@export var SPEED = 150.
var weapon : Weapon
var wpn_paths : = preload("res://Weapons/wpn_path.gd")
var wpn = wpn_paths.new()

var held_wpns : Array = ["pistol","rifle"]
var curr_wpn : int = 0

func _ready() -> void:
	equip_weapon(held_wpns[curr_wpn])
	pass

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionx := Input.get_axis("ui_left", "ui_right")
	if directionx:
		velocity.x = directionx * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	var directiony := Input.get_axis("ui_up", "ui_down")
	if directiony:
		velocity.y = directiony * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	move_and_slide()
	look_at(get_global_mouse_position())
	
func _process(delta: float) -> void:
	if $Shoot_timer.is_stopped():
		if Input.is_action_pressed("shoot"):
			weapon.shoot($Firepoint)
			$Shoot_timer.start(weapon.firerate / (weapon.firerate * weapon.firerate))
		
	if Input.is_action_just_pressed("weapon_swap"):
		if curr_wpn == 0:
			curr_wpn = 1
		else :
			curr_wpn = 0
		equip_weapon(held_wpns[curr_wpn])
	
	
func equip_weapon(index : String):
	weapon = wpn.wpn_paths[index]
	$CanvasLayer/Label.text = wpn.wpn_paths[index].name
	pass
