extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_spawing_algorithm_spawn_new_wave(waveData):
	for i in waveData:
		var enemy = load("res://Enemies/" + i[0] + ".tscn").instantiate()
		get_node("Lane" + str(i[1]) + "path").add_child(enemy, true)
		await get_tree().create_timer(0.5).timeout # Small delay between spawns, ensures enemies don't stack on eachother
