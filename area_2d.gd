extends Area2D

@export var speed = 200
@export var damage = 5
var target = Vector2.ZERO


func _ready():
	var direction = (target - global_position).normalized()
	var velocity = direction * speed

func _physics_process(delta):
	position += velocity * delta

func _process(delta: float) -> void:
	pass
