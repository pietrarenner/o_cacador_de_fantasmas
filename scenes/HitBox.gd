extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		get_tree().call_group("hud", "updateLives")
		print(body.name)
		#owner.queue_free()
		#get_tree().reload_current_scene()
