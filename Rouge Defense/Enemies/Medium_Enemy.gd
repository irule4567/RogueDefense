extends Area2D

var health = EnemyProperties.enemy_data["Medium_enemy"].get("health")
@onready var _animated_sprite = $Animation
signal attack(is_attacking)
signal death()
var dead # Used to prevent weird issues with death animation
# Called when the node enters the scene tree for the first time.
func _ready():
	dead = false



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(health)
	if health <= 0 && dead == false:
		dead = true
		die()


func _on_area_entered(area):
	if dead == false:
		for i in TowerProperties.tower_data:
			#print(TowerProperties.tower_data[i]["attack_name"])
			#print(area.name)
			if area.name.find(TowerProperties.tower_data[i]["attack_name"]) != -1: # Enemy is hit by a shot
				#print(area.name)
				health = health - TowerProperties.tower_data[i]["damage"]
				await get_tree().create_timer(TowerProperties.tower_data[i]["attack_time_dissapate"]).timeout
				if TowerProperties.tower_data[i]["type"] != "Insta": # remove area if it is a projectile and not attached to an insta that already freed itself
					area.queue_free()
				#print("enemy takes damage")
			elif area.name.find(TowerProperties.tower_data[i]["name"]) != -1: # Enemy is attacking a tower
				_animated_sprite.play("Attack")
				attack.emit(true)
		

func die():
	_animated_sprite.play("Death")
	


func _on_area_exited(area):
	if dead == false:
		var is_tower = false
		for i in TowerProperties.tower_data:
			if area.name.find(TowerProperties.tower_data[i]["name"]) != -1: # Area that left was a tower, not a shot
				is_tower = true
		if is_tower == true:
			attack.emit(false)
			_animated_sprite.play("Walk")


func _on_animation_animation_finished():
	if _animated_sprite.animation == "Death":
		#print("DEATH")
		emit_signal("death")
