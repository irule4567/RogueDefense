extends CanvasLayer

@onready var text = $TextboxContainer/MarginContainer/HBoxContainer/Dialogue
@onready var resource_arrow = $ResourceArrow
@onready var tower_arrow = $TowerArrow
@onready var generator_arrow = $GeneratorArrow
@onready var text_box = $TextboxContainer
@onready var dialogue = ["Hello.", "Welcome to Rouge Defense.", "Here I will teach you the basics of defending yourself.", 
"First, you’ll need to understand the basic mechanics of the game.", "Over here in the top left is your resource count.",
"You need these resources to place your towers from the icons on the top." ,"You generate resources over time, \nbut you’ll want to also place some resource producers to speed up your resource generation.",
"Here, place a resource generator now."]
var dialogue_num
#var dialogue_active

# Called when the node enters the scene tree for the first time.
func _ready():
	dialogue_num = 0
	#dialogue_active = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dialogue_num < dialogue.size():
		text.text = dialogue[dialogue_num]

#func _on_visibility_changed(): # Initially shown
#	dialogue_active = true

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			dialogue_num = dialogue_num + 1
			print(dialogue_num)
			if dialogue_num == 4:
				resource_arrow.show()
			if dialogue_num == 5:
				resource_arrow.hide()
				tower_arrow.show()
			if dialogue_num == 6:
				tower_arrow.hide()
			if dialogue_num == 7:
				generator_arrow.show()
			#print(dialogue.size())
			if dialogue_num == dialogue.size():
				text_box.hide()
