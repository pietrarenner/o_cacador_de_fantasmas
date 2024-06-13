extends CharacterBody2D

var direction = Vector2.RIGHT
@onready var edgeCheckLeft := $EdgeCheckLeft
@onready var edgeCheckRight := $EdgeCheckRight
@onready var sprite := $SimpleGhostSprite

func _physics_process(delta: float) -> void:
	var found_edge = not edgeCheckRight.is_colliding() or not edgeCheckLeft.is_colliding()
	
	if is_on_wall() or found_edge:
		sprite.flip_h = direction.x > 0
		direction *= -1
		
	velocity = direction * 85
	move_and_slide()

func _on_hurt_box_body_entered(body: Node2D) -> void:
	queue_free()
	if body.is_in_group("fireball"):
		body.queue_free()
