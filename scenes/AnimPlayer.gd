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
var isColliding := false 
var count := 0
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

func animate_side():
	if velocity.x > 0:
		sprite.play("right")
		fireball_spawn_point.position.x = abs(fireball_spawn_point.position.x)
	elif velocity.x < 0:
		sprite.play("left")
		fireball_spawn_point.position.x = -abs(fireball_spawn_point.position.x)
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
	if left and fireball_spawn_point.position.x < 0:
		spawn_fireball(-1)
	elif right and fireball_spawn_point.position.x > 0:
		spawn_fireball(1)
	elif up:
		spawn_fireball(0)
	while(isColliding and count > 50):
		pisca()
		count = 0;
	if(isColliding):
		count+=1;

func _on_hurt_box_body_entered(body: Node2D) -> void:
	if body is Boss:
		isColliding = true
	else:
		pisca()
	
func pisca():
	var knockback_tween := get_tree().create_tween()
	sprite.modulate = Color(1,0,0,1)
	knockback_tween.tween_property(sprite, "modulate", Color(1,1,1,1), 0.25)

func spawn_fireball(direction: int):
	var new_fireball = FIREBALL.instantiate()
	new_fireball.set_direction(direction)
	add_sibling(new_fireball)
	new_fireball.global_position = fireball_spawn_point.global_position
	
	var max_distance

	if(direction < 0):
		max_distance = new_fireball.position + Vector2(-80,0)
	elif(direction > 0):
		max_distance = new_fireball.position + Vector2(80,0)
	else:
		max_distance = new_fireball.position + Vector2(0,-80)
	new_fireball.set_max_pos(max_distance)

func _on_hurt_box_body_exited(body: Node2D) -> void:
	isColliding = false
