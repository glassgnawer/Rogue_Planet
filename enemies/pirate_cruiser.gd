extends CharacterBody2D

@onready var base = get_node('/root/Game/main_base')
@export var MAX_HEALTH := 50.0

var health : float

func _ready():
	health = MAX_HEALTH

func _physics_process(delta):
	var direction = global_position.direction_to(base.global_position)
	look_at(base.global_position)
	velocity = direction * 150.0
	move_and_slide()


func die():
	get_node("Death_explosion").emitting = true



func damage(attack: Attack):
	health -= attack.attack_damage
	if health <= 0:
		die()
		$Timer.start()

func _on_timer_timeout():
	queue_free()














