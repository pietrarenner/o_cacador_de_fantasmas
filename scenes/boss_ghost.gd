extends CharacterBody2D

var direction = Vector2.RIGHT
var speed = 100
var is_following = false
@onready var sprite := $SimpleGhostSprite
@export var target : CharacterBody2D

func _physics_process(delta: float) -> void:
	velocity = position.direction_to(target.position) * speed
	if position.distance_to(target.position) < 350 or is_following:
		is_following = true
		move_and_slide()
