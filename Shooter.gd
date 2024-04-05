extends Area2D
class_name Shooter

@export var fire_rate := 0.1
@export var rotation_speed := 5.0
@export var projectile_type: PackedScene
@export var projectile_speed := 1000
@export var projectile_range := 2000
@export var projectile_damage := 3
@export var projectile_spread := 0.0

@onready var firerate_timer := $FireRate_Timer as Timer
@onready var shoot_sound := $ShootSound as AudioStreamPlayer2D


func _physics_process(delta):
	var targets = get_overlapping_bodies()
	if targets.size() > 0:
		var target = targets.front()
		var target_pos: Vector2 = target.global_position
		var target_rot: float = global_position.direction_to(target_pos).angle()
		rotation = lerp_angle(rotation, target_rot, rotation_speed * delta)


func instantiate_projectile():
	var projectile: Projectile = projectile_type.instantiate()
	add_child(projectile)
	projectile.start(projectile_speed, projectile_range, projectile_damage)
	projectile.global_position = %Muzzle.global_position
	projectile.global_rotation = %Muzzle.global_rotation + randf_range(-projectile_spread, projectile_spread)
	


func shoot():
	firerate_timer.start(fire_rate)
	var targets = get_overlapping_bodies()
	if targets.size() > 0:
		shoot_sound.play()
		instantiate_projectile()
	


#func shoot():
#	firerate_timer.start()
#	var targets = get_overlapping_bodies()
#	if targets.size() > 0:
#		shoot_sound.play()
#		const BULLET = preload("res://bullet.tscn")
#		var new_bullet = BULLET.instantiate()
#		new_bullet.global_position = %Muzzle.global_position
#		new_bullet.global_rotation = %Muzzle.global_rotation
#		%Muzzle.add_child(new_bullet)


func _on_firerate_timer_timeout():
	shoot()
