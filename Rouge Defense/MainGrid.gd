extends TileMap


var GridWidth = 9
var GridHeight = 5
#var GridScaleFactor = 7 # How much to scale tiles by based on how much MainGrid was scaled
var Dic = {}
var Selected_tower
var building



func _ready():
	for x in GridWidth:
		for y in GridHeight:
			Dic[str(Vector2(x,y))] = {
				"Position": str(Vector2(x,y))
			}
			#set_cell(0, Vector2(x,y), 0, Vector2i(0,0), 0)

func _process(delta):
	var tile = local_to_map(get_global_mouse_position())
	
	#if Dic.has(str(tile)):
		##set_cell(1, tile, 1, Vector2i(0,0), 0)
		#print(Dic[str(tile)])
	
	if Input.is_action_pressed("Click") && building == true:
		#print("Place tower ", Selected_tower, " at position", Dic[str(tile)])
		var new_tower = load("res://Test_Tower.tscn").instantiate()
		new_tower.position = tile*Vector2i(108,108)+Vector2i(54,54)
		building = false
		get_node("Towers").add_child(new_tower, true)



func _on_tower_button_pressed():
	Selected_tower = "res://Test_Tower.tscn"
	building = true
