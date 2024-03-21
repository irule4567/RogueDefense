extends Node

var tower_data = {"Basic_Shooter": {
	"name": "Basic_Shooter",
	"damage": 1,
	"health": 300,
	"ROF": 1,
	"cost": 100,
	"attack_name": "Basic_Shot",
	"recharge": 5,
	"attack_time_dissapate": 0,
	"type": "Attacker"
},
"Resource_Generator": {
	"name": "Resource_Generator",
	"damage": 0,
	"health": 300,
	"ROF": 0,
	"cost": 50,
	"attack_name": "N/A",
	"recharge": 5,
	"attack_time_dissapate": 0,
	"type": "Producer"
},
"Wall": {
	"name": "Wall",
	"damage": 0,
	"health": 4000,
	"ROF": 0,
	"cost": 50,
	"attack_name": "N/A",
	"recharge": 30,
	"attack_time_dissapate": 0,
	"type": "Wall"
},
"Mine": {
	"name": "Mine",
	"damage": 90,
	"health": 300,
	"ROF": 0,
	"cost": 25,
	"attack_name": "1x1_Boom",
	"recharge": 30,
	"attack_time_dissapate": 1,
	"type": "Insta"
}}
# Holds data for each tower
# Note: Naming scheme for shots is towername_shot
# Note: Ignore previous note, that naming scheme messed with the code
# Note: attack_time_dissapate is used for dissapating projectiles. Currently used to make explosion animation play, but could be used for projectile destruction animations

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
