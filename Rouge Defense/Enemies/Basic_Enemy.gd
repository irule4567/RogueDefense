extends Area2D

var self_properties = EnemyProperties.enemy_data.get("Basic_enemy")
@onready var _animated_sprite = $Animation
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
			_animated_sprite.play("Attack")
			attack.emit(true)
		

func die():
	_animated_sprite.play("Death")
	


func _on_area_exited(area):
	var is_tower = false
	for i in TowerProperties.tower_data:
		if area.name.find(TowerProperties.tower_data[i]["name"]) != -1: # Area that left was a tower, not a shot
			is_tower = true
	if is_tower == true:
		attack.emit(false)
		_animated_sprite.play("Walk")


func _on_animation_animation_finished():
	if _animated_sprite.animation == "Death":
		self.queue_free()
