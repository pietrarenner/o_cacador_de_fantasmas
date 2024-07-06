extends CharacterBody2D

const SPEED = 400.0
var direction = 1
var max_pos = Vector2.ZERO

func _physics_process(delta: float) -> void:
	# se está indo para a direita ou esquerda
	#if direction > 0 or direction < 0:
		#position.x += SPEED * direction * delta
	#else:
		#position.y += SPEED * -1 * delta
		
	var result = move_and_collide(velocity*delta)
	if(result != null):
		if(result.get_collider() is SimpleGhost):
			result.get_collider().queue_free() 
		queue_free()
	
	if(max_pos != Vector2.ZERO):
		compare_positions()
	
func set_direction(dir: int):
	direction = dir
	if dir < 0:
		$AnimatedSprite2D.flip_h = true
		$CollisionShape2D.rotation = -1.5708
		$AnimatedSprite2D.rotation = 0
		velocity.x = -SPEED
	elif dir > 0:
		$AnimatedSprite2D.flip_h = false
		$CollisionShape2D.rotation = -1.5708
		$AnimatedSprite2D.rotation = 0
		velocity.x = SPEED
	else:
		$AnimatedSprite2D.rotation = -1.5708
		$CollisionShape2D.rotation = 0
		velocity.y = -SPEED

func set_max_pos(max_distance):
	max_pos = max_distance

func compare_positions():
	#print(position.x)
	#print(max_pos.x)
	if direction > 0:
		if position.x > max_pos.x:
			queue_free()
	elif direction < 0:
		if position.x < max_pos.x:
			queue_free()
	else:
		if(position.y < max_pos.y):
			queue_free()
