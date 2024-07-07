extends CanvasLayer

@onready var livesLabel : Label = $LivesLabel
@onready var scoreLabel : Label = $ScoreLabel

func _ready() -> void:
	setLives(5)
	setScore(0)

func setLives(lives: int):
	livesLabel.text = "LIVES : " + str(lives)
	
func setScore(score: int):
	scoreLabel.text = "SCORE : " +str(score)
