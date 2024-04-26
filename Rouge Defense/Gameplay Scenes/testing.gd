extends Node2D

#@onready var main_game = preload("res://Gameplay Scenes/main_menu.tscn").instantiate()

var enemies = [] # Tracks enemy count, used for determining end of level
var recent_enemy_wave = [] # Tracks enemies in individual waves, used for health based wave progression
var wave_num
var last_wave
var all_enemies_spawned
var total_wave_health

@onready var spawn_timer = $SpawnTimer

signal end_level()
signal lose_level()
signal start_new_wave()

# Called when the node enters the scene tree for the first time.
func _ready():
	wave_num = 1
	total_wave_health = 0
	SignalBus.connect("game_over", game_over)
	last_wave = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(enemies)
	for i in enemies:
		if !is_instance_valid(i):
			enemies.erase(i)
	for i in recent_enemy_wave:
		if !is_instance_valid(i):
			recent_enemy_wave.erase(i)
	if last_wave == false && !recent_enemy_wave.is_empty():
		var curr_health = 0
		#print(recent_enemy_wave)
		for enemy in recent_enemy_wave:
			curr_health = curr_health + enemy.curr_health
		#print("curr_health: ", curr_health)
		#print("total_wave_health: ", total_wave_health)
		if curr_health < total_wave_health/2:
			#print("spawn timer manual stop")
			spawn_timer.stop()
			start_new_wave.emit()
			
	if enemies.is_empty() and all_enemies_spawned == true:
		#print("end of level")
		end_level.emit()


func _on_spawing_algorithm_spawn_new_wave(waveData):
	recent_enemy_wave = []
	total_wave_health = 0
	for i in waveData:
		var enemy = load("res://Enemies/" + i[0] + ".tscn").instantiate()
		get_node("Lane" + str(i[1]) + "path").add_child(enemy, true)
		enemies.push_back(enemy)
		recent_enemy_wave.push_back(enemy)
		total_wave_health = total_wave_health + enemy.max_health
		await get_tree().create_timer(1).timeout # Small delay between spawns, ensures enemies don't stack on eachother
	wave_num = wave_num + 1
	if last_wave == true:
		#print("Last wave")
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
	if GlobalVars.level >= GlobalVars.num_levels: # End game if last level
		get_tree().change_scene_to_file("res://Gameplay Scenes/main_menu.tscn")
	else:
		get_tree().reload_current_scene()


func _on_retry_pressed():
	get_tree().reload_current_scene()
