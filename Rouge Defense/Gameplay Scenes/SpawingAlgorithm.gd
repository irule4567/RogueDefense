extends Node

var waveData = []

var credits = [] # Credits per wave

var num_waves
var wave

var max_time_between_waves

var initial_wait

signal spawn_new_wave(waveData)
signal last_wave()

@onready var spawn_timer = get_node("../SpawnTimer")

# Called when the node enters the scene tree for the first time.
func _ready():
	wave = 0
	if GlobalVars.level > GlobalVars.num_levels:
		get_tree().change_scene_to_file("res://Gameplay Scenes/main_menu.tscn")
	credits = GlobalVars.level_credits[GlobalVars.level]
	#credits = [1, 2, 3, 5, 8, 11, 14]
	num_waves = credits.size()
	max_time_between_waves = 30
	initial_wait = 15
	await get_tree().create_timer(initial_wait).timeout
	_set_new_wave()
	#waveData = [["Basic_Enemy", 1], ["Basic_Enemy", 2], ["Basic_Enemy", 3], ["Basic_Enemy", 4], ["Basic_Enemy", 5]]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _set_new_wave():
	print(wave)
	waveData = []
	var rem_credits = credits[wave]
	#print(rem_credits)
	while rem_credits > 0:
		var lane = randi() % 5 + 1
		var enemy_num = randi() % EnemyProperties.enemy_data.size()
		#print(enemy_num)
		while EnemyProperties.enemy_data.get(EnemyProperties.enemy_data.keys()[enemy_num]).weight > rem_credits:
			enemy_num = randi() % EnemyProperties.enemy_data.size()
		waveData.append([EnemyProperties.enemy_data[EnemyProperties.enemy_data.keys()[enemy_num]].name, lane])
		rem_credits = rem_credits - EnemyProperties.enemy_data.get(EnemyProperties.enemy_data.keys()[enemy_num]).weight
	spawn_new_wave.emit(waveData)
	if wave+1 == num_waves:
		#print("Last wave signal")
		emit_signal("last_wave")
	elif wave+1 < num_waves:
		wave = wave + 1
		spawn_timer.start(max_time_between_waves)
	else:
		print("Some issue with wave spawning.")
	#await get_tree().create_timer(max_time_between_waves).timeout
	#print("Timer ends")
	#print(wave)
	
	


func _on_spawn_timer_timeout():
	_set_new_wave()


func _on_basic_level_start_new_wave():
	_set_new_wave()


