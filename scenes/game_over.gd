extends Control

@onready var diedsound = $DiedSound

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	diedsound.play()
	$ExitGame.connect("pressed", Callable(self, "_on_quit_button_pressed"))
	
func _physics_process(delta: float) -> void:
	var restart := Input.is_action_just_pressed("restart")
	if(restart):
		get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_quit_button_pressed():
	get_tree().quit()

