extends CanvasLayer

@onready var livesLabel : Label = $LivesLabel
@onready var collectiblesLabel : Label = $CollectiblesLabel

func _ready() -> void:
	setLives(5)
	setCollectibles(0)

func updateLives():
	print("updateLives do HUD!")
	
func updateCollectibles():
	print("updateCollectibles do HUD!")

func setLives(lives: int):
	livesLabel.text = "Lives : " + str(lives)
	
func setCollectibles(collectibles: int):
	collectiblesLabel.text = "Collectibles : " +str(collectibles)
