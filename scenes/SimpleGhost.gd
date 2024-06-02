extends CharacterBody2D

var direction = Vector2.RIGHT
var lives = 1
@onready var edgeCheckLeft := $EdgeCheckLeft
@onready var edgeCheckRight := $EdgeCheckRight
@onready var sprite := $SimpleGhostSprite

func _physics_process(delta: float) -> void:
	var found_edge = not edgeCheckRight.is_colliding() or not edgeCheckLeft.is_colliding()
	
	if is_on_wall() or found_edge:
		sprite.flip_h = direction.x > 0
		direction *= -1
		
	velocity = direction * 50
	move_and_slide()
