extends Area2D

var enemiesInRange
var shotReady

# Called when the node enters the scene tree for the first time.
func _ready():
	enemiesInRange = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if enemiesInRange >= 1 && shotReady == true:
		#print("Shot fired")
		var shot = load("res://Tower_shots/Test_tower_shot.tscn").instantiate()
		shot.position = $Sprite2D/ShotPosition.position
		shotReady = false
		get_node("Shots").add_child(shot, true)


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
