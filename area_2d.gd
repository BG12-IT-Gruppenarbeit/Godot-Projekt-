extends Area2D

@export var speed = 200
@export var damage = 5
var target = Vector2.ZERO
var direction = Vector2.ZERO


func _ready():
	if target != Vector2.ZERO:
		direction = (target - global_position).normalized()
	else:
		queue_free()

func _physics_process(delta):
	position += direction * speed * delta

func _on_body_entered(body: Node2D):
	if body.name == "Player":
		body.take_damage(damage)
		queue_free()
