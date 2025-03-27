extends Node2D

@onready var main_menu = $UI/MainMenu
@onready var address_entry = $UI/MainMenu/MarginContainer/VBoxContainer/LineEdit
@onready var environment = $Environment

const GOBLIN = preload("res://Enemies/enemy_types/goblin.tscn")
const PLAYER = preload("res://player.tscn")
const PORT = 9999

var enet_peer = ENetMultiplayerPeer.new()
var host_id

var players: Array[Player] = []
var enemies: Array[Enemy] = []

func _ready() -> void:
	await get_tree().create_timer(0).timeout
	if main_menu and address_entry and environment:
		$MultiplayerSpawner.spawn_function = add_player
	else:
		print("Fehler: Einer der Knoten wurde nicht gefunden!")
		return

func _process(delta: float) -> void:
	pass

func _on_host_pressed() -> void:
	main_menu.hide()
	environment.show()
	
	enet_peer.create_server(PORT)
	multiplayer.multiplayer_peer = enet_peer
	multiplayer.peer_connected.connect(
		func (pid):
			$MultiplayerSpawner.spawn(pid)
	)
	
	$MultiplayerSpawner.spawn(multiplayer.get_unique_id())
	_host_id(multiplayer.get_unique_id())
	print(_host_id(multiplayer.get_unique_id()))

func _host_id(pid):
	host_id = pid

func _on_join_pressed() -> void:
	main_menu.hide()
	environment.show()
	
	enet_peer.create_client("localhost", PORT)
	multiplayer.multiplayer_peer = enet_peer

func add_player(peer_id):
	var player = PLAYER.instantiate()
	player.name = str(peer_id)
	player.global_position = $Environment/PlayerSpawners.get_child(players.size()).global_position
	players.append(player)
	
	return player
