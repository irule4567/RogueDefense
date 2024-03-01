extends TileMap


var GridWidth = 9
var GridHeight = 5
#var GridScaleFactor = 7 # How much to scale tiles by based on how much MainGrid was scaled
var Dic = {}

func _ready():
	for x in GridWidth:
		for y in GridHeight:
			Dic[str(Vector2(x,y))] = {
				"Position": str(Vector2(x,y))
			}
			#set_cell(0, Vector2(x,y), 0, Vector2i(0,0), 0)

func _process(delta):
	var tile = local_to_map(get_global_mouse_position())
	
	if Dic.has(str(tile)):
		#set_cell(1, tile, 1, Vector2i(0,0), 0)
		print(Dic[str(tile)])
