extends StaticBody2D


var Bullet = preload("res://Towers/GreenBullet.tscn")
var bulletDamage = 10
var pathName
var currTargets = []
var curr

func _process(_delta):
	if is_instance_valid(curr):
		self.look_at(curr.global_position)


func _on_tower_2_body_entered(body):
	print(body.name)
	if "SoldierA" in body.name:
		var tempArray = []
		currTargets = get_node("Tower2").get_overlapping_bodies()
		
		for i in currTargets:
			if "SoldierA" in i.name:
				tempArray.append(i)
	   
		var currTarget = null


		for i in tempArray:
			if currTarget == null:
				currTarget = i.get_node("../")
			else:
				if i.get_parent().get_progress() > currTarget.get_progress():
					currTarget = i.get_node("../")
		
		curr = currTarget
		pathName = currTarget.get_parent().name

		var tempBullet = Bullet.instantiate()
		tempBullet.pathName = pathName
		tempBullet.bulletDamage = bulletDamage
		var bulletContainer = get_node("BulletContainer2")
		bulletContainer.call_deferred("add_child",tempBullet)
		tempBullet.global_position = $Aim2.global_position



func _on_tower_2_body_exited(body):
	currTargets = get_node("Tower2").get_overlapping_bodies()

