extends Node

var enemy_data = {"Basic_enemy": {
	"name": "Basic_enemy",
	"health" : 10,
	"speed" : 20,
	"weight" : 1,
	"attack": 1,
	"attack_cooldown": 1
},
"Medium_enemy": {
	"name": "Medium_enemy",
	"health" : 26,
	"speed" : 20,
	"weight" : 2,
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
