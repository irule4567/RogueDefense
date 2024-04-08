extends CanvasLayer

@onready var text = $TextboxContainer/MarginContainer/HBoxContainer/Dialogue
@onready var resource_arrow = $ResourceArrow
@onready var tower_arrow = $TowerArrow
@onready var generator_arrow = $GeneratorArrow
@onready var text_box = $TextboxContainer
@onready var resource_area = $ResourceArea
@onready var shooter_area = $ShooterArea
@onready var dialogue = ["Hello.", "Welcome to Rouge Defense.", "Here I will teach you the basics of defending yourself.", 
"First, you’ll need to understand the basic mechanics of the game.", "Over here in the top left is your resource count.",
"You need these resources to place your towers, which will show up here." ,"You generate resources over time, \nbut you’ll want to also place some resource producers to speed up your resource generation.",
"Here, place a resource generator in the selected area.", "Great work.", "However, you’re going to need more than just resources to defend yourself.",
"Since we’re in a hurry, I’ll give you some resources right now.", "Now use those resources to place a basic shooter in the middle row, I think I see some enemies.",
"Here they come! \nYou can handle this yourself now, right?"]
var dialogue_num
var dialogue_active

signal show_producer()
signal show_shooter()
signal hide_producer()
signal give_resource()
signal end_tutorial()

# Called when the node enters the scene tree for the first time.
func _ready():
	dialogue_num = 0
	dialogue_active = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dialogue_num < dialogue.size():
		text.text = dialogue[dialogue_num]

#func _on_visibility_changed(): # Initially shown
#	dialogue_active = true

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and dialogue_active == true:
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
			if dialogue_num == 8:
				resource_area.show()
				generator_arrow.hide()
				text_box.hide()
				dialogue_active = false
				emit_signal("show_producer")
			if dialogue_num == 9:
				emit_signal("hide_producer")
			if dialogue_num == 10:
				emit_signal("give_resource")
			if dialogue_num == 12:
				shooter_area.show()
				text_box.hide()
				dialogue_active = false
				emit_signal("show_shooter")
			if dialogue_num == 13:
				shooter_area.hide()
			#print(dialogue.size())
			if dialogue_num == dialogue.size():
				emit_signal("end_tutorial")
				text_box.hide()
				dialogue_active = false


func _on_main_grid_tutorial_gen_place():
	dialogue_active = true
	text_box.show()
	resource_area.hide()


func _on_main_grid_tutorial_shoot_place():
	dialogue_active = true
	text_box.show()
	shooter_area.hide()
