extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var enemy = load("res://Enemies/Test_Enemy.tscn").instantiate()
	get_node("Lane1path").add_child(enemy, true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
