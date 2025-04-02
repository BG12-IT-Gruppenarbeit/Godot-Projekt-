extends Node2D

@onready var main_menu = $UI/MainMenu
@onready var oid_lbl = $UI/MainMenu/MarginContainer/VBoxContainer/OID
@onready var oid_input = $UI/MainMenu/MarginContainer/VBoxContainer/OidInput
@onready var environment = $Environment
@onready var delay_timer = $DelayTimer
@onready var multiplayerspawner = $MultiplayerSpawner

const GOBLIN = preload("res://Enemies/enemy_types/goblin.tscn")
const PLAYER = preload("res://player.tscn")
const PORT = 9999

var enet_peer = ENetMultiplayerPeer.new()
var host_id: float

var players: Array[Player] = []
var enemies: Array[Enemy] = []

func _ready() -> void:
	# Überprüfen, ob der Timer existiert, andernfalls dynamisch erstellen
	if delay_timer == null:
		print("DelayTimer node ist nicht vorhanden! Erstelle einen neuen Timer...")
		delay_timer = Timer.new()
		add_child(delay_timer)
		delay_timer.start()  # Starte den Timer
		await delay_timer.timeout

	# Überprüfen, ob der MultiplayerSpawner existiert, ansonsten instanziiere ihn
	if multiplayerspawner == null:
		print("MultiplayerSpawner wurde dynamisch erstellt.")
	else:
		print("MultiplayerSpawner wurde gefunden!")

		multiplayerspawner.spawn_function = add_player  # Setze die spawn_function

	# Warte auf die Verbindung
	await Multiplayer.noray_connected
	if oid_lbl != null:
		print("oid_lbl wurde gefunden!")
		oid_lbl.text = Noray.oid
	else:
		print("Fehler: oid_lbl ist null oder wurde nicht gefunden.")

func _on_host_pressed() -> void:
	#Multiplayer.host()
	enet_peer.create_server(PORT)
	multiplayer.multiplayer_peer = enet_peer
	
	multiplayer.peer_connected.connect(
		func (pid):
			print("Peer " + str(pid) + " has joined the game!")
			multiplayerspawner.spawn(pid)
	)
	
	multiplayerspawner.spawn(multiplayer.get_unique_id())
	_host_id(multiplayer.get_unique_id())
	print("Host ID is " + str(multiplayer.get_unique_id()))
	
	main_menu.hide()
	environment.show()

func _host_id(pid):
	host_id = pid

func _on_join_pressed() -> void:
	#Multiplayer.join(oid_input.text)
	enet_peer.create_client("localhost", PORT)
	multiplayer.multiplayer_peer = enet_peer
	
	main_menu.hide()
	environment.show()

func add_player(peer_id):
	var player = PLAYER.instantiate()
	player.name = str(peer_id)
	player.global_position = $Environment/PlayerSpawners.get_child(players.size()).global_position
	players.append(player)
	
	return player


func _on_copy_oid_pressed() -> void:
	DisplayServer.clipboard_set(Noray.oid)
