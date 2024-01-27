class_name Item extends Node #Currently not sure if this needs to extend anything, but I'll keep it just to be safe

var itemName: String = "missingno"
var id: int = 0             # Which item this is
						# 0: Something's wrong! This shouldn't happen!
						# 1: Rubber Chicken (normal)
						# 2: Squirt Flower (normal)
						# 3: Horn (normal)
						# 4: Juggling Balls (normal)
						# 5: Rubber Chicken (lethal)
						# 6: Squirt Flower (lethal (acid))
						# 7: Juggling Balls (grenades)
						##TODO: I'll fill out this list more later
						
var susSightHeld: bool = false #If people are suspicious on seeing this item held
var susHearUsed: bool = false  #If people are suspicious on hearing this item used
						#If this makes no sound then obviously this is false
var susSightUsed: bool = false #If people are suspicious on seeing this item used

var lethal: bool = false; #If this item is lethal on contact


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#Just a debug function
func debug():
	var safety: String
	if lethal:
		safety = "I am extremely dangerous"
	else:
		safety = "I am child-friendly"
	print("I am called " + str(itemName) + ", my ID is " + str(id) + ", and " + safety)
