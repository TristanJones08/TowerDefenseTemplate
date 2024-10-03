extends Panel

@onready var tower= preload ("res://Scenes/green_bullet_tower.tscn")
var currTile 


func _on_gui_input(event):
	var tempTower = tower.instantiate()
	if event is InputEventMouseButton and event.button_mask == 1:
		#print("Left button down")
		add_child(tempTower)

		tempTower.process_mode = Node.PROCESS_MODE_DISABLED

		tempTower.scale = Vector2(0.32,0.32)

	elif event is InputEventMouseMotion and event.button_mask == 1:
		if get_child_count()>1:
			get_child(1).global_position = get_global_mouse_position()

			var mapPath = get_tree().get_root().get_node("Main/TileMap")
			var tile = mapPath.local_to_map(get_global_mouse_position())
			currTile = mapPath.get_cell_atlas_coords(0, tile, false)
			if (currTile == Vector2i(0,0)):
				get_child(1).get_node("Panel").modulate = Color.GREEN
			else:
				get_child(1).get_node("Panel").modulate = Color.RED

	elif event is InputEventMouseButton and event.button_mask == 0:
		if get_global_mouse_position().x >= 2944:
			if get_child_count()>1:
				get_child(1).queue_free()
			else:
				if get_child_count() > 1:
					get_child(1).queue_free()

		var path = get_tree().get_root().get_node("Main/Towers")

		path.add_child(tempTower)
		tempTower.global_position = get_global_mouse_position()
		tempTower.get_node("Panel").hide()
		
	else:
		if get_child_count()> 1:
			get_child(1).queue_free()

