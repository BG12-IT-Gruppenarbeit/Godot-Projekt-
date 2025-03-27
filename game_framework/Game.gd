extends Node2D

@onready var main_menu = $UI/MainMenu
@onready var oid_lbl = $UI/MainMenu/MarginContainer/VBoxContainer/OID
@onready var oid_input = $UI/MainMenu/MarginContainer/VBoxContainer/OidInput
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
	if main_menu and oid_input and oid_lbl and environment:
		$MultiplayerSpawner.spawn_function = add_player
	else:
		print("Fehler: Einer der Knoten wurde nicht gefunden!")
		return
	
	if Noray.is_connected():
		print("Erfolgreich verbunden: ", Noray.oid)
	else:
		print("Verbindung zum Server konnte nicht hergestellt werden.")
		return
	
	await Multiplayer.noray_connected
	if $UI and $UI/MainMenu and $UI/MainMenu/MarginContainer/VBoxContainer/OID and $UI/MainMenu/MarginContainer/VBoxContainer/OidInput and $Environment:
		oid_lbl.text = Noray.oid
	else:
		print("Fehler: Einer der Knoten wurde nicht gefunden!")
		return
	
	
	

func _process(delta: float) -> void:
	pass

func _on_host_pressed() -> void:
	main_menu.hide()
	environment.show()
	
	Multiplayer.host()
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
	
	Multiplayer.join(oid_input.text)

func add_player(peer_id):
	var player = PLAYER.instantiate()
	player.name = str(peer_id)
	player.global_position = $Environment/PlayerSpawners.get_child(players.size()).global_position
	players.append(player)
	
	return player


func _on_copy_oid_pressed() -> void:
	DisplayServer.clipboard_set(Noray.oid)
