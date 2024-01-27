extends Node

#The random number generator
var randGen = RandomNumberGenerator.new()

var holdingItem: bool = false #Whether the clown is already holding an item.
var heldItem: Item = Item.new()

#Projectiles
var waterProj = preload("res://Projectiles/WaterDroplet.tscn")
var juggleProj = preload("res://Projectiles/JuggleBall.tscn")
var chickProj = preload("res://Projectiles/RubberChicken.tscn")
var balloonProj = preload("res://Projectiles/BalloonAnimal.tscn")




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
		
	##Toss the item if R is pressed
	if ev is InputEventKey and ev.keycode == KEY_R and not ev.echo and ev.pressed:
		TossItem()
		
	#If the left mouse button is pressed, do projectile stuff with the item
	#IMPORTANT: THIS WILL BREAK IF THE PLAYER'S POSITION IN THE TREE MOVES. YOU WILL HAVE TO EDIT IT!
	if ev is InputEventMouseButton and ev.button_index == MOUSE_BUTTON_LEFT and ev.pressed:
		#var mousePos = ev.global_position
		var mousePos = get_node(^"../").get_global_mouse_position()
		var player = get_node(^"../Player")
		var playPos = player.global_position
		print("Player position is " + str(playPos))
		print("Mouse position is " + str(mousePos))
		UseItem(mousePos, playPos)
		
#Call this to use the held item	
func UseItem(mousePos, playPos):
	print("Using item " + str(heldItem.itemName) + "(" + str(heldItem.id) + ")")
	match heldItem.id:
		0: 
			print("You are holding nothing!")
		1: #Nonlethal chicken
			var newProj = chickProj.instantiate()
			newProj.startPos = playPos
			newProj.targetPos = mousePos
			add_child(newProj)
		2:  #Nonlethal water droplet
			var newProj = waterProj.instantiate()
			newProj.startPos = playPos
			newProj.targetPos = mousePos
			add_child(newProj)
		3: #Balloon Animal (Lethal)
			var newProj = balloonProj.instantiate()
			newProj.startPos = playPos
			newProj.targetPos = mousePos
			newProj.lethal = true
			add_child(newProj)
		4: #Nonlethal juggling balls / nose
			var newProj = juggleProj.instantiate()
			newProj.startPos = playPos
			newProj.targetPos = mousePos
			add_child(newProj)
		5:  #Lethal chicken
			var newProj = chickProj.instantiate()
			newProj.startPos = playPos
			newProj.targetPos = mousePos
			newProj.lethal = true
			add_child(newProj)
			
		6:  #Lethal water droplet
			var newProj = waterProj.instantiate()
			newProj.startPos = playPos
			newProj.targetPos = mousePos
			newProj.lethal = true
			add_child(newProj)
			
		7: #Lethal ball/nose
			var newProj = juggleProj.instantiate()
			newProj.startPos = playPos
			newProj.targetPos = mousePos
			newProj.lethal = true
			add_child(newProj)
		
		_:
			print("id " + str(heldItem.id) + "not implemented")

#Generate a random number that will be turned into an item
func RandomItem():
	
	#If already holding an item, don't make one
	if(holdingItem):
		print("Already holding an item, dumbass.")
		##CONSIDER: tossing the item currently held instead of rejecting the command
	#If not, get the number
	else:
		var randNum: int = randGen.randf_range(1, 8);  #NOTE: Remember to update this as needed
		#NOTE: This seems to be lower inclusive, upper exclusive. this means the highest number will never be rolled.
		#In short, always make it one higher than we're using
		
		print("Making item " + str(randNum))
		holdingItem = true
		
		#Actually make the item
		heldItem = Item.new()
		heldItem.id = randNum
		match randNum:
			1: #Rubber Chicken (normal)
				heldItem.itemName = "Rubber Chicken"
			2: #Squirt Flower (normal)
				heldItem.itemName = "Water Gun"
			3: #Horn (normal)
				heldItem.itemName = "Balloon Animal"
				heldItem.lethal = true
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
		
	
	
#ditch the currently held item
func TossItem():
	if(holdingItem):
		holdingItem = false; 
		heldItem = Item.new() #This is just a "nothing" item
		print("Ditched item")
	else:
		print("You're not holding an item, dumbass")
	##TODO: And once those items are represented by things in the game world, create one on the floor
	
