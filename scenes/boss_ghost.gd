extends CharacterBody2D
class_name Boss

var direction = Vector2.RIGHT
var speed = 100
var is_following = false
var lives = 3
var count = 0
@onready var sprite := $BossSprite
@export var target : CharacterBody2D

func animate_side():
	if position.distance_to(target.position) < 1:
		sprite.stop()
	elif velocity.x > 0:
		sprite.play("right")
	elif velocity.x < 0:
		sprite.play("left")

func _physics_process(delta: float) -> void:
	count+=1;
	velocity = position.direction_to(target.position) * speed
	if position.distance_to(target.position) < 350 or is_following:
		is_following = true
		animate_side()
		move_and_slide()
	if position.distance_to(target.position) < 1 and count>60:
		get_tree().call_group("hud", "updateLives")
		count = 0
	#print(position)
	#print(target.position)

func _on_hurt_box_body_entered(body: Node2D) -> void:
	print("entrou")
	var knockback_tween := get_tree().create_tween()
	sprite.modulate = Color(1,0,0,1)
	if lives > 1:
		lives-=1
		knockback_tween.tween_property(sprite, "modulate", Color(1,1,1,1), 0.25)
	else:
		get_tree().call_group("door", "open")
		knockback_tween.tween_property(sprite, "modulate", Color(1,0,0,1), 0.025)
		knockback_tween.connect("finished", Callable(self, "_on_tween_finished"))

func _on_tween_finished() -> void:
	queue_free()
