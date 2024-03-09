extends Node

var enemy_data = {"Test_enemy": {
	"name": "Test_enemy",
	"health" : 10,
	"speed" : 50,
	"weight" : 1,
	"attack": 1,
	"attack_cooldown": 1
}}
# Note: attacks are currently done on a per-frame basis
# May want to change to use a timer with attack cooldown instead

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
