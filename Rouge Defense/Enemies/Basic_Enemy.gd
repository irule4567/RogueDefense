extends Area2D

var self_properties = EnemyProperties.enemy_data.get("Basic_enemy")
signal attack(is_attacking)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self_properties["health"] <= 0:
		die()


func _on_area_entered(area):
	for i in TowerProperties.tower_data:
		#print(TowerProperties.tower_data[i]["attack_name"])
		#print(area.name)
		if area.name.find(TowerProperties.tower_data[i]["attack_name"]) != -1: # Enemy is hit by a shot
			self_properties["health"] = self_properties["health"] - TowerProperties.tower_data[i]["damage"]
			area.queue_free()
			#print("enemy takes damage")
		elif area.name.find(TowerProperties.tower_data[i]["name"]) != -1: # Enemy is attacking a tower
			attack.emit(true)
		

func die():
	self.queue_free()


func _on_area_exited(area):
	for i in TowerProperties.tower_data:
		if area.name.find(TowerProperties.tower_data[i]["name"]) != -1: # Enemy is no longer attacking a tower
			attack.emit(false)
