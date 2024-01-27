extends Node

#The random number generator
var randGen = RandomNumberGenerator.new()

var holdingItem: bool = false; #Whether the clown is already holding an item.
var heldItem: Item


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _input(ev):
	##Run this code IF a key is pressed, the key is E, it's not being held, and the button is not released
	##(Without that last bit it would trigger on both button press and release)
	if ev is InputEventKey and ev.keycode == KEY_E and not ev.echo and ev.pressed:
		RandomItem()
		
	if ev is InputEventKey and ev.keycode == KEY_R and not ev.echo and ev.pressed:
		TossItem()

#Generate a random number that will be turned into an item
func RandomItem():
	
	#If already holding an item, don't make one
	if(holdingItem):
		print("Already holding an item, dumbass.")
		##CONSIDER: tossing the item currently held instead of rejecting the command
	#If not, get the number
	else:
		var randNum: int = randGen.randf_range(1, 8);  #Remember to update this
		#NOTE: This seems to be lower inclusive, upper exclusive. this means the highest number will never be rolled.
		#Always make it one higher than we're using
		
		print("Making item " + str(randNum))
		holdingItem = true
		
		#Actually make the item
		heldItem = Item.new()
		heldItem.id = randNum
		match randNum:
			1: #Rubber Chicken (normal)
				heldItem.itemName = "Rubber Chicken"
			2: #Squirt Flower (normal)
				heldItem.itemName = "Squirt Flower"
			3: #Horn (normal)
				heldItem.itemName = "Horn"
			4: #Juggling Balls (normal)
				heldItem.itemName = "Juggling Balls"
			5: #Rubber Chicken (lethal)
				heldItem.itemName = "Rubber Chicken"
				heldItem.susSightUsed = true
				heldItem.lethal = true
			6: #Squirt Flower (acid)
				heldItem.itemName = "Squirt Flower"
				heldItem.susSightUsed = true
				heldItem.lethal = true
			7: #Juggling Balls (grenades)
				heldItem.itemName = "Juggling Balls"
				heldItem.susSightUsed = true
				heldItem.susHearUsed = true
				heldItem.lethal = true
			_: 
				print("No implementation for item with id " + str(randNum))
		
		heldItem.debug()
		
	##TODO: take this number and make an item
	
	
#ditch the currently held item
func TossItem():
	if(holdingItem):
		holdingItem = false;
		print("Ditched item")
	else:
		print("You're not holding an item, dumbass")
	##TODO: when this has actual items attached, remember to actually remove them!
	##TODO: And once those items are represented by things in the game world, create one on the floor
	
