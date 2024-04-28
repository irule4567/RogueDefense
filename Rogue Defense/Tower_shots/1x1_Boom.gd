extends Area2D
@onready var _animated_sprite = $Explosion

# Called when the node enters the scene tree for the first time.
func _ready():
	_animated_sprite.play("Explosion");


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
