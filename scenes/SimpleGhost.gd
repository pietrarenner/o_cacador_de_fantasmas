extends CharacterBody2D
class_name SimpleGhost

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
	get_tree().call_group("dyingSounds", "playGhostDyingSound")
	var knockback_tween := get_tree().create_tween()
	sprite.modulate = Color(1,0,0,1)
	knockback_tween.tween_property(sprite, "modulate", Color(1,0,0,1), 0.025)
	knockback_tween.connect("finished", Callable(self, "_on_tween_finished"))
	if body.is_in_group("fireball"):
		body.queue_free()
	get_tree().call_group("hud", "updateScore", 5)
		
func _on_tween_finished() -> void:
	queue_free()
