extends Node2D

@onready var shooter_button = $PanelContainer/Towers/Basic_Shooter_button
@onready var producer_button = $PanelContainer/Towers/Resource_Generator_button
@onready var wall_button = $PanelContainer/Towers/Wall_button
@onready var mine_button = $PanelContainer/Towers/Mine_button

var enemy_spawned
var enemy

#@onready var tutorialText = $/root/Tutorial/TutorialText

# Called when the node enters the scene tree for the first time.
func _ready():
	enemy_spawned = false
	wall_button.hide()
	mine_button.hide()
	shooter_button.hide()
	producer_button.hide()
	#get_tree().paused = true
	#await get_tree().create_timer(1).timeout
	#tutorialText.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(is_instance_valid(enemy))
	#print(enemy_spawned)
	if enemy_spawned == true and !(is_instance_valid(enemy)): # Enemy has spawned and is dead
		print("Tutorial over")


func _on_tutorial_text_show_producer():
	producer_button.show()


func _on_tutorial_text_show_shooter():
	shooter_button.show()
	


func _on_tutorial_text_hide_producer():
	producer_button.hide()


func _on_tutorial_text_end_tutorial():
	producer_button.show()
	enemy = load("res://Enemies/Basic_Enemy.tscn").instantiate()
	get_node("Lane3path").add_child(enemy, true)
	enemy_spawned = true
