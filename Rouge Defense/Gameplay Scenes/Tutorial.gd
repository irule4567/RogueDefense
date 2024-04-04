extends Node2D

@onready var shooter_button = $PanelContainer/Towers/Basic_Shooter_button
@onready var producer_button = $PanelContainer/Towers/Resource_Generator_button
@onready var wall_button = $PanelContainer/Towers/Wall_button
@onready var mine_button = $PanelContainer/Towers/Mine_button

#@onready var tutorialText = $/root/Tutorial/TutorialText

# Called when the node enters the scene tree for the first time.
func _ready():
	wall_button.hide()
	mine_button.hide()
	#get_tree().paused = true
	#await get_tree().create_timer(1).timeout
	#tutorialText.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
