extends Node

var waveData = []

var credits = [] # Credits per wave

var num_waves

var time_between_waves

var initial_wait

signal spawn_new_wave(waveData)
signal last_wave()

# Called when the node enters the scene tree for the first time.
func _ready():
	credits = [1, 2, 3, 5, 8, 11, 14]
	num_waves = credits.size()
	time_between_waves = 15
	initial_wait = 1
	await get_tree().create_timer(initial_wait).timeout
	_set_new_wave(0)
	#waveData = [["Basic_Enemy", 1], ["Basic_Enemy", 2], ["Basic_Enemy", 3], ["Basic_Enemy", 4], ["Basic_Enemy", 5]]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _set_new_wave(wave):
	for i in credits[wave]:
		var lane = randi() % 5 + 1
		waveData.append(["Basic_Enemy", lane])
	spawn_new_wave.emit(waveData)
	await get_tree().create_timer(time_between_waves).timeout
	#print("Timer ends")
	#print(wave)
	if wave+1 < num_waves:
		_set_new_wave(wave + 1)
	else:
		emit_signal("last_wave")
