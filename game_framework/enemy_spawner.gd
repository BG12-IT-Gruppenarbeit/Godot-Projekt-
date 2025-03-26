extends Node2D

@export var enemy_scene : PackedScene
@export var spawn_cooldown = 10

var spawn = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.start(randf_range(spawn_cooldown * .8, spawn_cooldown * 1.2))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if spawn:
		var enemy = enemy_scene.instantiate()
		get_parent().add_child(enemy)
		enemy.position = self.global_position
		spawn = false
		$Timer.start(randf_range(spawn_cooldown * .8, spawn_cooldown * 1.2))
		pass
	if $Timer.time_left < 2:
		$PointLight2D.visible = true
	else:
		$PointLight2D.visible = false


func _on_timer_timeout() -> void:
	spawn = true
