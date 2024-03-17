extends PathFollow2D

var self_properties = EnemyProperties.enemy_data.get("Basic_enemy")
var speed = self_properties["speed"]

func _physics_process(delta):
	move(delta)

func move(delta):
	set_progress(get_progress() + delta * speed)
	#print(get_progress())


func _on_test_enemy_attack(is_attacking):
	if is_attacking == true:
		speed = 0
	elif is_attacking == false:
		speed = self_properties["speed"]
