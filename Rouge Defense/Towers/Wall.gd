extends Area2D


var health = TowerProperties.tower_data["Wall"].get("health")
var enemies_attacking
@onready var mainGrid = get_node("../..")

# Called when the node enters the scene tree for the first time.
func _ready():
	enemies_attacking = []


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if health <= 0:
		die()
	for i in enemies_attacking:
		health = health - EnemyProperties.enemy_data[i.name]["attack"]


func _on_area_entered(area):
	for i in EnemyProperties.enemy_data:
		if area.name.find(EnemyProperties.enemy_data[i]["name"]) != -1: # Tower is being attacked
			enemies_attacking.append(area)

func die():
	self.queue_free()
	
func _on_area_exited(area):
	if enemies_attacking.find(area) != -1: # If the area that left was an enemy
		enemies_attacking.erase(area)
