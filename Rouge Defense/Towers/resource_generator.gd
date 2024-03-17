extends Area2D


var health = TowerProperties.tower_data["Resource_Generator"].get("health")
var enemies_attacking
@onready var mainGrid = $/root/Testing/MainGrid

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


func _on_generation_timer_timeout():
	mainGrid.resource_count = mainGrid.resource_count + 25
