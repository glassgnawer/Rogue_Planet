extends Area2D

var travelled_distance = 0

func _physics_process(delta):
	const SPEED = 1000
	const RANGE = 1500
	var direction = Vector2.UP.rotated(rotation)
	position += direction * SPEED * delta
	
	travelled_distance += SPEED * delta
	if travelled_distance > RANGE:
		queue_free()




