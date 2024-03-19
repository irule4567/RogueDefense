extends TileMap


var GridWidth = 9
var GridHeight = 5
#var GridScaleFactor = 7 # How much to scale tiles by based on how much MainGrid was scaled
var Dic = {}
var Selected_tower
var building
var resource_count
var deck = [] # Array of tower names for towers available in the level
var recharges = [] # Array of current recharge times for each tower
@onready var resource_label = $/root/Testing/ResourceCount



func _ready():
	resource_count = 500
	for i in TowerProperties.tower_data.keys():
		deck.append(TowerProperties.tower_data.get(i))
		recharges.append(0)
	for x in GridWidth:
		for y in GridHeight:
			Dic[str(Vector2(x,y))] = {
				"Position": str(Vector2(x,y)),
				"Taken": false
			}
			#set_cell(0, Vector2(x,y), 0, Vector2i(0,0), 0)

func _process(delta):
	resource_label.set_text(str(resource_count))
	var tile = local_to_map(get_global_mouse_position())
	
	
	#if Dic.has(str(tile)):
		##set_cell(1, tile, 1, Vector2i(0,0), 0)
		#print(Dic[str(tile)])
	
	if Input.is_action_pressed("Click") && building == true && TowerProperties.tower_data[Selected_tower].cost <= resource_count && Dic.has(str(tile)):
		#print("Place tower ", Selected_tower, " at position", Dic[str(tile)])
		if Dic[str(tile)]["Taken"] == false:
			Dic[str(tile)]["Taken"] = true
			var new_tower = load("res://Towers/" + Selected_tower + ".tscn").instantiate()
			get_node("Towers").add_child(new_tower, true)
			new_tower.position = tile*Vector2i(108,108)+Vector2i(54,54)
			building = false
			resource_count = resource_count - TowerProperties.tower_data[Selected_tower].cost



func _on_tower_button_pressed():
	Selected_tower = "Basic_Shooter"
	building = true


func _on_passive_income_timer_timeout():
	resource_count = resource_count + 25


func _on_resource_producer_button_pressed():
	Selected_tower = "Resource_Generator"
	building = true


func _on_towers_child_exiting_tree(node):
	var tile = local_to_map(node.position)
	Dic[str(tile)]["Taken"] = false


func _on_wall_button_pressed():
	Selected_tower = "Wall"
	building = true
