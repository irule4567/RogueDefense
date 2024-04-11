extends Area2D

var enemiesInRange
var shotReady
var health = TowerProperties.tower_data["Basic_Shooter"].get("health")
var enemies_attacking
@onready var test_hp = $Test
@onready var _animated_sprite = $Animation

# Called when the node enters the scene tree for the first time.
func _ready():
	enemies_attacking = []
	enemiesInRange = 0
	_animated_sprite.play("Idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if health <= 0:
		die()
	if enemiesInRange >= 1 && shotReady == true:
		#print("Shot fired")
		play_anim("Shoot")
		shotReady = false
	elif enemiesInRange == 0:
		play_anim("Idle")
	for i in enemies_attacking:
		health = health - EnemyProperties.enemy_data[i.name]["attack"]


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

func play_anim(anim):
	if _animated_sprite.animation != anim:
		_animated_sprite.play(anim)


func _on_area_exited(area):
	if enemies_attacking.find(area) != -1: # If the area that left was an enemy
		enemies_attacking.erase(area)


func _on_animation_animation_looped():
	if _animated_sprite.animation == "Shoot":
		var shot = load("res://Tower_shots/Basic_Shot.tscn").instantiate()
		shot.position = $Animation/ShotPosition.position
		get_node("Shots").add_child(shot, true)
