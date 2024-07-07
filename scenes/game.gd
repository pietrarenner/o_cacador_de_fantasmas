extends Node2D

var isDoorOpen := false
var lives := 5
var count := 0
var score := 0
@onready var livesLabel := $HUD/LivesLabel
@onready var collectiblesLabel := $HUD/ScoreLabel
var player : CharacterBody2D
var sceneLimit : Marker2D
@onready var hud : CanvasLayer = $HUD 
@onready var music := $Music
@onready var ghostDyingSound := $GhostDyingSound
var currentScene = null

func _ready() -> void:
	RenderingServer.set_default_clear_color("#02041c")
	sceneLimit = $Level/SceneLimit
	player = $Level/AnimPlayer
	currentScene = $Level
	music.play()
	
func updateLives():
	if lives > 1:
		lives-=1
		hud.setLives(lives)
	else:
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
		
func updateScore(ghostPoints: int):
	score+=ghostPoints
	hud.setScore(score)

func goto_scene(path: String):	
	currentScene.free()
	var res := ResourceLoader.load(path)
	currentScene = res.instantiate()	
	add_child(currentScene)
	sceneLimit = null
	isDoorOpen = false

func _physics_process(delta: float) -> void:
	if sceneLimit == null:
		player = $Level/AnimPlayer
		sceneLimit = $Level/SceneLimit		
		
func nextPhase():
	if isDoorOpen:
		if currentScene.name == "Level":
			call_deferred("goto_scene", "res://levels/level_3.tscn")
		elif currentScene.name == "Level2":
			call_deferred("goto_scene", "res://levels/level_3.tscn")
		elif currentScene.name == "Level3":
			get_tree().change_scene_to_file("res://scenes/game_finished.tscn")

func setOpenDoor():
	isDoorOpen = true

func playGhostDyingSound():
	ghostDyingSound.play()
