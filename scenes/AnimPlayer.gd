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
const FIREBALL = preload("res://scenes/fireball.tscn")
@onready var fireball_spawn_point = $fireball_spawn_point
	
func get_side_input():
	velocity.x = 0
	var vel := Input.get_axis("left", "right")
	var jump := Input.is_action_just_pressed('jump')

	if is_on_floor() and jump:		
		velocity.y = jump_speed
		jumpsound.play()
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
	var left = Input.is_action_just_pressed("fire_left") 
	var right = Input.is_action_just_pressed("fire_right") 
	var up = Input.is_action_just_pressed("fire_up") 
	if left or right or up:
		spawn_fireball()

func _on_hurt_box_body_entered(body: Node2D) -> void:
	var knockback_tween := get_tree().create_tween()
	sprite.modulate = Color(1,0,0,1)
	knockback_tween.tween_property(sprite, "modulate", Color(1,1,1,1), 0.25)

func spawn_fireball():
	var new_fireball = FIREBALL.instantiate()
	add_sibling(new_fireball)
	new_fireball.position = fireball_spawn_point.global_position
