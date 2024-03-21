extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var waveData = [["Basic_Enemy", 1], ["Basic_Enemy", 2], ["Basic_Enemy", 3], ["Basic_Enemy", 4], ["Basic_Enemy", 5]]
	for i in waveData:
		var enemy = load("res://Enemies/" + i[0] + ".tscn").instantiate()
		get_node("Lane" + str(i[1]) + "path").add_child(enemy, true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
