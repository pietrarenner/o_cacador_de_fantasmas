extends CharacterBody2D

const SPEED = 100.0
var direction = 1
@onready var sprite = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# se está indo para a direita ou esquerda
	position.x += SPEED * direction * delta
	
	# se está indo para cima
	# position.y += SPEED * 1 * delta
	
func ste_direction(dir):
	direction = dir
	if dir < 0:
		sprite.flip_h = true
		sprite.flip_v = false
	elif dir > 0:
		sprite.flip_h = false
		sprite.flip_v = false
	else:
		sprite.flip_v = true
