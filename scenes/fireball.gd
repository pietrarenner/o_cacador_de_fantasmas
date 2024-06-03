extends CharacterBody2D

const SPEED = 100.0
var direction = 1
@onready var sprite = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	position.x += SPEED * direction * delta
	
func ste_direction(dir):
	direction = dir
	if dir < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
