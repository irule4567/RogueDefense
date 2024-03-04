extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#print("Shot is created")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position = self.position + Vector2(3, 0)
	#print("Shot moves")
