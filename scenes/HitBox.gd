extends Area2D

@export var sprite : AnimatedSprite2D

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		get_tree().call_group("hud", "updateLives")
		print(body.name)
		#owner.queue_free()
		#get_tree().reload_current_scene()

func _on_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
