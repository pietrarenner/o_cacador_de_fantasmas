extends CanvasLayer

@onready var label3 : Label = $Label3

func _ready() -> void:
	setScore(0)
	
func setScore(score: int):
	print("entrou")
	label3.text = "Score : " +str(score)
