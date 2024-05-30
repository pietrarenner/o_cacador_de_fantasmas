extends Node2D

var lives := 5
var count := 0
var collectibles := 0
@onready var livesLabel := $HUD/LivesLabel
@onready var collectiblesLabel := $HUD/CollectiblesLabel
var player : CharacterBody2D
var sceneLimit : Marker2D
@onready var hud : CanvasLayer = $HUD 
#var currentScene = null

func _ready() -> void:
	RenderingServer.set_default_clear_color("#02041c")
	sceneLimit = $Level/SceneLimit
	player = $Level/AnimPlayer
	#$HUD/LivesLabel.text = "Lives : " + str(lives)
	#$HUD/CollectiblesLabel.text = "Collectibles : " + str(lives)
	#sceneLimit = $Level/SceneLimit
	#player = $Level/AnimPlayer
	#
func updateLives():
	if lives > 1:
		lives-=1
		hud.setLives(lives)
	else:
		print("Jogador perdeu!")
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
		
func updateCollectibles():
	collectibles+=1
	hud.setCollectibles(collectibles)
		
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

func _physics_process(delta: float) -> void:
	if sceneLimit == null:
		player = $Level/AnimPlayer
		sceneLimit = $Level/SceneLimit		
		#print("sceneLimit: ", sceneLimit)
		#print("player: ", player)
