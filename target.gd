extends Area2D



func _on_body_entered(body):
	print("Collided")
	if body.name == "Juggle Ball":
		print("Target is hit")
