extends CharacterBody2D

@export var dodge_chance: float = 0.3  # 30% Chance zum Ausweichen
@export var block_chance: float = 0.2  # 20% Chance zum Blocken
@export var counter_attack_chance: float = 0.15  # 15% Chance für Gegenangriff

func react_to_attack():
	if randf() < dodge_chance:
		dodge()
	elif randf() < block_chance:
		block()
	elif randf() < counter_attack_chance:
		counter_attack()

func dodge():
	print("Gegner weicht aus!")
	var dodge_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	velocity = dodge_direction * 150
	move_and_slide()

func block():
	print("Gegner blockt den Angriff!")

func counter_attack():
	print("Gegner startet einen Gegenangriff!")
