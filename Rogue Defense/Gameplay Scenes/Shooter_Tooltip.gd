extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_basic_shooter_button_mouse_entered():
	show()


func _on_basic_shooter_button_mouse_exited():
	hide()
