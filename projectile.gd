extends Area2D
class_name Projectile

var travelled_distance = 0
var speed: int
var range: int
var damage: int
var velocity: Vector2
var target: Node2D  # only used by homing missiles
var AoE: float

@onready var sprite := $Shot1 as Sprite2D
@onready var collision_shape := $CollisionShape2D as CollisionShape2D

func start(_speed: int, _range: int, _damage: int):
	speed = _speed
	range = _range
	damage = _damage
	

func _physics_process(delta):
	var direction = Vector2.UP.rotated(rotation)
	position += direction * speed * delta
	
	travelled_distance += speed * delta
	if travelled_distance > range:
		queue_free()

func _on_body_entered(body):
	if body.has_method("damage"):
		
		var attack = Attack.new()
		attack.attack_damage = damage
		body.damage(attack)
	queue_free()


