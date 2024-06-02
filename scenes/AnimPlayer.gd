extends CharacterBody2D
class_name Player

@export var speed = 300.0
@export var lives := 5
@export var jump_speed := -850.0
@export var gravity := 2500.0
@onready var sprite = $PlayerSprite
@onready var jumpsound := $JumpSound
@onready var ray_cast_right := $RayCastRight
@onready var ray_cast_left := $RayCastLeft
var knockback_vector := Vector2.ZERO
	
func get_side_input():
	velocity.x = 0
	var vel := Input.get_axis("left", "right")
	var jump := Input.is_action_just_pressed('jump')

	if is_on_floor() and jump:		
		velocity.y = jump_speed
		# Emitir o sinal "jumped"
		# jumped.emit()
		#get_tree().call_group("hud", "updateLives")
		#jumpsound.play()
		# Controle de volume (0 = padrão)
		#AudioServer.set_bus_volume_db(2, 0)
	if knockback_vector != Vector2.ZERO:
		velocity = knockback_vector
	else:
		velocity.x = vel * speed
	#print(velocity.x)	

func animate_side():
	if velocity.x > 0:
		sprite.play("right")
	elif velocity.x < 0:
		sprite.play("left")
	else:
		sprite.stop()
		
func move_side(delta):
	velocity.y += gravity * delta
	get_side_input()
	animate_side()
	move_and_slide()
	
func _physics_process(delta):
	move_side(delta)

func _on_hurt_box_body_entered(body: Node2D) -> void:
	#if ray_cast_right.is_colliding():
		#take_damage(Vector2(-500, 500))
	#elif ray_cast_left.is_colliding():
		#take_damage(Vector2(500, 500))
	#get_tree().call_group("hud", "updateLives")
	var knockback_tween := get_tree().create_tween()
	sprite.modulate = Color(1,0,0,1)
	knockback_tween.tween_property(sprite, "modulate", Color(1,1,1,1), 0.25)

#func take_damage(knockback_force := Vector2.ZERO, duration := 0.25):
	#if knockback_force != Vector2.ZERO:
		#knockback_vector = knockback_force
		
	#var knockback_tween := get_tree().create_tween()
	#knockback_tween.tween_property(self, "knockback_vector", Vector2.ZERO, duration)
	#sprite.modulate = Color(1,0,0,1)
	#knockback_tween.tween_property(sprite, "modulate", Color(1,1,1,1), duration)
