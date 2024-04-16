extends TileMap


var GridWidth = 9
var GridHeight = 5
#var GridScaleFactor = 7 # How much to scale tiles by based on how much MainGrid was scaled
var Dic = {}
var Selected_tower
var building
var resource_count
var deck = [] # Array of tower names for towers available in the level
var recharges = [] # Array of current recharge times for each tower. Currently just has whether the tower is recharged or not
@onready var resource_label = $/root/BasicLevel/ResourceCount



func _ready():
	resource_count = 500
	for i in TowerProperties.tower_data.keys():
		#print(TowerProperties.tower_data.get(i))
		deck.append(TowerProperties.tower_data.get(i))
		var recharge_timer = get_tree().create_timer(0.0)
		recharges.append(recharge_timer)
	for x in GridWidth:
		for y in GridHeight:
			Dic[str(Vector2(x,y))] = {
				"Position": str(Vector2(x,y)),
				"Taken": false
			}
			#set_cell(0, Vector2(x,y), 0, Vector2i(0,0), 0)

func _process(delta):
	#print(recharges)
	resource_label.set_text(str(resource_count))
	var tile = local_to_map(get_global_mouse_position())
	for tower in deck:
		var recharge_bar_name = TowerProperties.tower_data[tower.name].name + "_Recharge"
		#print(recharge_bar_name)
		var recharge_bar = get_node("../PanelContainer/Towers/" + TowerProperties.tower_data[tower.name].name + "_button/" + recharge_bar_name)
		#print("../PanelContainer/Towers/" + TowerProperties.tower_data[tower.name].name + "_button/" + recharge_bar_name)
		recharge_bar.set_as_ratio(recharges[deck.find(TowerProperties.tower_data[tower.name])].time_left / TowerProperties.tower_data[tower.name].recharge) 
	
	#if Dic.has(str(tile)):
		##set_cell(1, tile, 1, Vector2i(0,0), 0)
		#print(Dic[str(tile)])
	# Check for click, selected tower, resources, tile exists, and recharge
	if Input.is_action_pressed("Click") && building == true && TowerProperties.tower_data[Selected_tower].cost <= resource_count && Dic.has(str(tile)) && recharges[deck.find(TowerProperties.tower_data[Selected_tower])].time_left == 0:
		#print("Place tower ", Selected_tower, " at position", Dic[str(tile)])
		if Dic[str(tile)]["Taken"] == false: # Tower is placed
			Dic[str(tile)]["Taken"] = true
			var tower_button = get_node("../PanelContainer/Towers/" + Selected_tower + "_button")
			tower_button.button_pressed = false
			var new_tower = load("res://Towers/" + Selected_tower + ".tscn").instantiate()
			get_node("Towers").add_child(new_tower, true)
			new_tower.position = tile*Vector2i(108,108)+Vector2i(54,54)
			building = false
			resource_count = resource_count - TowerProperties.tower_data[Selected_tower].cost
			_set_tower_timer(Selected_tower)
			
			#var tower_timer = Timer.new()
			#add_child(tower_timer)
			#tower_timer.wait_time = TowerProperties.tower_data[Selected_tower].recharge
			#tower_timer.one_shot = true
			#tower_timer.start()
			#tower_timer.connect("timeout", self, "_on_timer_timeout")
			#recharges[deck.find(TowerProperties.tower_data[Selected_tower])] = tower_timer



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


func _set_tower_timer(tower):
	#recharges[deck.find(TowerProperties.tower_data[tower])] = true
	#print("before timer")
	recharges[deck.find(TowerProperties.tower_data[tower])] = get_tree().create_timer(TowerProperties.tower_data[tower].recharge)
	#print("after timer")
	#recharges[deck.find(TowerProperties.tower_data[tower])] = false


func _on_mine_button_pressed():
	Selected_tower = "Mine"
	building = true
