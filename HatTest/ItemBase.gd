extends Node #Currently not sure if this needs to extend anything

var id: int             # Which item this is
						# 1: Rubber Chicken
						# 2: Squirt Flower
						# 3: Horn
						# 4: Juggling Balls
						##TODO: I'll fill out this list more later
						
var susSightHeld: bool  #If people are suspicious on seeing this item held
var susHearUsed: bool   #If people are suspicious on hearing this item used
						#If this makes no sound then obviously this is false
var susSightUsed: bool  #If people are suspicious on seeing this item used

var lethal: bool; #If this item is lethal on contact


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#Just a debug function
func _debug():
	print("This is item " + str(id))
