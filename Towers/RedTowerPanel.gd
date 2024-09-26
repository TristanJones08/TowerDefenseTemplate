extends Panel

@onready var tower= preload ("res://Towers/RedBulletTower.tscn")
var currTile 


func _on_gui_input(event):
	var tempTower = tower.instantiate()
	if event is InputEventMouseButton and event.button_mask == 1:
		#print("Left button down")
		add_child(tempTower)

		tempTower.process_mode = Node.PROCESS_MODE_DISABLED

	elif event is InputEventMouseMotion and event.button_mask == 1:
		get_child(1).global_position = event.global_position

	elif event is InputEventMouseButton and event.button_mask == 0:
		print("Left button Up")
		get_child(1).queue_free()
		var path = get_tree().get_root().get_node("Main/Towers")

		path.add_child(tempTower)
		tempTower.global_position = event.global_position
		tempTower.get_node("Area").hide()

