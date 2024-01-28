extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	print("collided")
	#get_node("..").Win()
	if(body.name =="JuggleBall"):
		print("collided with ball")
		get_node("..").Win()
	if(body.name =="RubberChicken"):
		print("collided with chicken")
		get_node("..").Win()
	if(body.name =="WaterDroplet"):
		print("collided with water droplet")
		get_node("..").Win()
	if(body.name == "Player"):
		print("collided with player")
		get_node("..").Win()
		#to do: delete this code so that you have to use the items to win
