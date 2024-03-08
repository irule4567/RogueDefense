extends PathFollow2D

var self_properties = EnemyProperties.enemy_data.get("Test_enemy")

func _physics_process(delta):
	move(delta)

func move(delta):
	set_progress(get_progress() + delta * self_properties["speed"])
	#print(get_progress())
