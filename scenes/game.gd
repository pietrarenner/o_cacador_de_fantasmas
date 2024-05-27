extends Node2D

var lives := 3
var count := 0
#@onready var livesLabel := $HUD/LivesLabel
#var player : CharacterBody2D
#var sceneLimit : Marker2D
#var currentScene = null
#
## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HUD/LivesLabel.text = "Lives : " + str(lives)
	$HUD/CollectiblesLabel.text = "Collectibles : " + str(lives)
	#sceneLimit = $Level/SceneLimit
	#player = $Level/AnimPlayer
	#
func updateLives():
	if lives > 0:
		lives-=1
		$HUD/LivesLabel.text = "Lives : " + str(lives)
		$HUD/CollectiblesLabel.text = "Collectibles : " + str(lives)
		#livesLabel.text = "Lives: " + str(lives)
	#else:
		#print("Jogador perdeu!")
		#get_tree().change_scene_to_file("res://scenes/game_over.tscn")
		
#func _physics_process(delta: float) -> void:
	#if sceneLimit == null:
		#player = $Level/AnimPlayer
		#sceneLimit = $Level/SceneLimit	
		#
	# ir para tela de game over + clicar tal coisa para recomeçar
	
	# para ir para a próxima fase

#func goto_scene(path: String):
	#$Level.free()	
	#var res := ResourceLoader.load(path)
	#currentScene = res.instantiate()	
	##player = get_child(0).get_node("AnimPlayer")
	#add_child(currentScene)
	#sceneLimit = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	count+=1
	if count==50:
		updateLives()
		count=0
	pass
