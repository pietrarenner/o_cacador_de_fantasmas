extends CharacterBody2D

var direction = Vector2.RIGHT
var speed = 100
var is_following = false
var lives = 3
var count = 0
@onready var sprite := $BossSprite
@export var target : CharacterBody2D

func animate_side():
	if velocity.x > 0:
		sprite.play("right")
	elif velocity.x < 0:
		sprite.play("left")
	else:
		sprite.stop()

func _physics_process(delta: float) -> void:
	count+=1;
	velocity = position.direction_to(target.position) * speed
	if position.distance_to(target.position) < 350 or is_following:
		is_following = true
		animate_side()
		move_and_slide()
	# trava na pessoa e tira vidas -> arrumar sprite
	if position.distance_to(target.position) < 1 and count>60:
		get_tree().call_group("hud", "updateLives")
		count = 0		
	#print(position)
	#print(target.position)

func _on_hurt_box_body_entered(body: Node2D) -> void:
	print("entrou")
	if lives > 1:
		lives-=1
		print(lives)
	else:
		queue_free()
	if body.is_in_group("fireball"):
		body.queue_free()
