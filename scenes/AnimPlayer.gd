extends CharacterBody2D

@export var speed = 300.0
@export var jump_speed := -1000.0
@export var gravity := 2500.0
@onready var sprite = $PlayerSprite
#@onready var jumpsound := $JumpSound
#@onready var box := preload("res://objects/box.tscn"

#signal jumped

#func _ready() -> void:
#	sprite = $PlayerSprite
	
func get_side_input():
	velocity.x = 0
	var vel := Input.get_axis("left", "right")
	var jump := Input.is_action_just_pressed('jump')

	if is_on_floor() and jump:		
		velocity.y = jump_speed
		# Emitir o sinal "jumped"
		# jumped.emit()
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
	#move_8way(delta)
	move_side(delta)
