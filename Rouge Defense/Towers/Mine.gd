extends Area2D


var health = TowerProperties.tower_data["Mine"].get("health")
var enemies_attacking
var armed
@onready var _animated_sprite = $Animation
@onready var mainGrid = get_node("../..")


# Called when the node enters the scene tree for the first time.
func _ready():
	enemies_attacking = []
	armed = false
	_animated_sprite.play("Unarmed")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if health <= 0:
		die()
	for i in enemies_attacking:
		health = health - EnemyProperties.enemy_data[i.name]["attack"]
		if armed == true:
			var Explosion = load("res://Tower_shots/1x1_Boom.tscn").instantiate()
			Explosion.position = $Animation/ExplosionOrigin.position
			get_node("Explosion").add_child(Explosion, true)
			armed = false
			die()


func _on_area_entered(area):
	for i in EnemyProperties.enemy_data:
		if area.name.find(EnemyProperties.enemy_data[i]["name"]) != -1: # Tower is being attacked
			enemies_attacking.append(area)

func die():
	_animated_sprite.hide()
	await get_tree().create_timer(TowerProperties.tower_data["Mine"]["attack_time_dissapate"]).timeout
	self.queue_free()
	
func _on_area_exited(area):
	if enemies_attacking.find(area) != -1: # If the area that left was an enemy
		enemies_attacking.erase(area)


func _on_arming_timer_timeout():
	armed = true
	_animated_sprite.play("Armed")
