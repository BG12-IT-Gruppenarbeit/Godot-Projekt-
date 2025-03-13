extends PanelContainer
class_name  Card
var player

func _ready() -> void:
	player = get_parent().get_parent().get_parent() #sucht den jeweiligen spieler.


func _process(delta: float) -> void:
	pass




func _notification(what: int) -> void:
	match what:
		NOTIFICATION_PREDELETE:	#see below
			on_predelete()

func on_predelete() -> void:
	Engine.time_scale = 1		#resumes gamespeed when card is selected
	


func _on_button_pressed() -> void:
	select()
	get_parent().get_parent().queue_free()

func select():
	pass
