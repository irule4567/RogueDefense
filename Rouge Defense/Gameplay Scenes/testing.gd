extends Node2D

#@onready var main_game = preload("res://Gameplay Scenes/main_menu.tscn").instantiate()

var enemies = [] # Tracks enemy count, used for determining end of level
var last_wave
var all_enemies_spawned

signal end_level()
signal lose_level()

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.connect("game_over", game_over)
	last_wave = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if enemies.is_empty() and all_enemies_spawned == true:
		end_level.emit()


func _on_spawing_algorithm_spawn_new_wave(waveData):
	for i in waveData:
		var enemy = load("res://Enemies/" + i[0] + ".tscn").instantiate()
		get_node("Lane" + str(i[1]) + "path").add_child(enemy, true)
		enemies.push_back(enemy)
		await get_tree().create_timer(0.5).timeout # Small delay between spawns, ensures enemies don't stack on eachother
	if last_wave == true:
		all_enemies_spawned = true


func _on_button_pressed():
	get_tree().paused = true


func _on_resume_pressed():
	get_tree().paused = false
	


func _on_spawing_algorithm_last_wave():
	last_wave = true


func _on_exit_to_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Gameplay Scenes/main_menu.tscn")


func game_over():
	lose_level.emit()


func _on_next_level_pressed():
	GlobalVars.level = GlobalVars.level + 1
	get_tree().reload_current_scene()


func _on_retry_pressed():
	get_tree().reload_current_scene()
