#extends CharacterBody2D
#
#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0
#
## Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
#
#func _physics_process(delta: float) -> void:
	## Add the gravity.
	#if not is_on_floor():
		#velocity.y += gravity * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()

## arquivo cohen
extends CharacterBody2D

@export var speed = 300.0
@export var jump_speed := -1000.0
@export var gravity := 2500.0
@onready var sprite = $PlayerSprite
#@onready var jumpsound := $JumpSound
#@onready var box := preload("res://objects/box.tscn"
#@export var box : PackedScene

signal jumped

#func _ready() -> void:
#	sprite = $PlayerSprite
	
func get_side_input():
	velocity.x = 0
	var vel := Input.get_axis("left", "right")
	#var jump := Input.is_action_just_pressed('jump')

	#if is_on_floor() and jump:		
		#velocity.y = jump_speed
		## Emitir o sinal "jumped"
		## jumped.emit()
		#get_tree().call_group("hud", "updateScore")	
		#jumpsound.play()
		# Controle de volume (0 = padrão)
		#AudioServer.set_bus_volume_db(2, 0)
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

#@export var speed = 300.0
#
#@onready var sprite = $PlayerSprite
#
#func get_8way_input():
	#var input_direction = Input.get_vector("left", "right", "up", "down")
	#velocity = input_direction * speed
	#
#func animate():
	#if velocity.x > 0:
		#sprite.play("right")
	#elif velocity.x < 0:
		#sprite.play("left")
	#elif velocity.y > 0:
		#sprite.play("down")
	#elif velocity.y < 0:
		#sprite.play("up")
	#else:
		#sprite.stop()
		#
#func move_8way(delta):
	#get_8way_input()
	#animate()
	#move_and_slide()
#
#func _physics_process(delta):
	#move_8way(delta)
