extends Node

#The random number generator
var randGen = RandomNumberGenerator.new()

var holdingItem: bool = false; #Whether the clown is already holding an item.


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#Generate a random number that will be turned into an item
func RandomItem():
	
	#If already holding an item, don't make one
	if(holdingItem):
		print("Already holding an item, dumbass.")
		##CONSIDER: tossing the item currently held instead of rejecting the command
	#If not, get the number
	else:
		var randNum: int = randGen.randf_range(1, 4);
	##TODO: take this number and make an item
	##TODO: have this function be called on a certain button press
	
