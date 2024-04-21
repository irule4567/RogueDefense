extends PathFollow2D

var self_properties = EnemyProperties.enemy_data.get("Medium_enemy")
var speed = self_properties["speed"]
@onready var _animated_sprite = $Basic_enemy/Animation

func _ready():
	_animated_sprite.play("Walk")

func _physics_process(delta):
	move(delta)

func move(delta):
	set_progress(get_progress() + delta * speed)
	#print(get_progress())


func _on_test_enemy_attack(is_attacking):
	if is_attacking == true:
		speed = 0
	elif is_attacking == false:
		speed = self_properties["speed"]


func _on_animation_animation_changed():
	if _animated_sprite.animation == "Death": # No speed while dying
		speed = 0


func _on_basic_enemy_death():
	self.queue_free()
