extends Node

var tower_data = {"Basic_Shooter": {
	"name": "Basic_Shooter",
	"damage": 1,
	"health": 300,
	"ROF": 1,
	"cost": 100,
	"attack_name": "Basic_Shot",
	"recharge": 5
},
"Resource_Generator": {
	"name": "Resource_Generator",
	"damage": 0,
	"health": 300,
	"ROF": 0,
	"cost": 50,
	"attack_name": "N/A",
	"recharge": 5
},
"Wall": {
	"name": "Wall",
	"damage": 0,
	"health": 4000,
	"ROF": 0,
	"cost": 50,
	"attack_name": "N/A",
	"recharge": 30
}}
# Holds data for each tower
# Note: Naming scheme for shots is towername_shot

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
