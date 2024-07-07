extends StaticBody2D

@onready var sprite = $AnimatedSprite2D
var isOnDoor := false
@onready var doorSound := $DoorSound
@onready var label := $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isOnDoor:
		if Input.is_action_just_pressed("restart_next_phase"):
			get_tree().call_group("door", "nextPhase")
			#isOnDoor = false
	
func open():
	sprite.play("opening")
	get_tree().call_group("door", "setOpenDoor")
	doorSound.play()

func _on_area_2d_body_entered(body: Node2D) -> void:
	#mostrar mensagem para a pessoa pressionar E para passar de fase
	if body is Player:
		label.visible = true
		isOnDoor = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		label.visible = false
		isOnDoor = false
