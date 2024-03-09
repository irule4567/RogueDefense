extends Area2D

var enemiesInRange
var shotReady
var self_properties = TowerProperties.tower_data["Test_Tower"]
var enemies_attacking

# Called when the node enters the scene tree for the first time.
func _ready():
	enemies_attacking = []
	enemiesInRange = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self_properties["health"] <= 0:
		die()
	if enemiesInRange >= 1 && shotReady == true:
		#print("Shot fired")
		var shot = load("res://Tower_shots/Test_tower_shot.tscn").instantiate()
		shot.position = $Sprite2D/ShotPosition.position
		shotReady = false
		get_node("Shots").add_child(shot, true)
	for i in enemies_attacking:
		self_properties["health"] = self_properties["health"] - EnemyProperties.enemy_data[i.name]["attack"]


func _on_aggro_range_area_entered(area):
	#print("Aggro range entered")
	#print(area.name)
	if(EnemyProperties.enemy_data.has(area.name) == true): # The area that entered is an enemy
		enemiesInRange = enemiesInRange + 1


func _on_aggro_range_area_exited(area):
	#print("Aggro range exited")
	if(EnemyProperties.enemy_data.has(area.name) == true): # The area that entered is an enemy
		enemiesInRange = enemiesInRange - 1


func _on_shot_timer_timeout():
	shotReady = true


func _on_area_entered(area):
	for i in EnemyProperties.enemy_data:
		if area.name.find(EnemyProperties.enemy_data[i]["name"]) != -1: # Tower is being attacked
			enemies_attacking.append(area)

func die():
	self.queue_free()
