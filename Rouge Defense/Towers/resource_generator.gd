extends Area2D


var health = TowerProperties.tower_data["Resource_Generator"].get("health")
var enemies_attacking
@onready var mainGrid = $/root/BasicLevel/MainGrid
@onready var _animated_sprite = $Animation
@onready var gen_timer = $GenerationTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	enemies_attacking = []


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if gen_timer.time_left <= 22: # return to idle
		play_anim("Idle")
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
	play_anim("Active")
	
	
func _on_area_exited(area):
	if enemies_attacking.find(area) != -1: # If the area that left was an enemy
		enemies_attacking.erase(area)

func play_anim(anim):
	if _animated_sprite.animation != anim:
		_animated_sprite.play(anim)
