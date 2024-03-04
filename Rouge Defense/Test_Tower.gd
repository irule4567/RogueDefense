extends Area2D

var enemyInRange
var shotReady

# Called when the node enters the scene tree for the first time.
func _ready():
	enemyInRange = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if enemyInRange == true && shotReady == true:
		print("Shot fired")
		var shot = load("res://Test_tower_shot.tscn").instantiate()
		shot.position = $Sprite2D/ShotPosition.position
		shotReady = false
		get_node("Shots").add_child(shot, true)


func _on_aggro_range_area_entered(area):
	print("Aggro range entered")
	enemyInRange = true


func _on_aggro_range_area_exited(area):
	print("Aggro range exited")
	enemyInRange = false


func _on_shot_timer_timeout():
	shotReady = true
