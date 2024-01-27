extends Node



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#Call this function when the target needs to die
func YourHonor():
	print("League of Legends")
	queue_free() #Death
	
#Call this function when the target is harassed by a nonlethal item
func Pranked():
	print("PRANKED")
	#TODO: figure out how we're actually going to have the target speak.
	#My default choice would be to temporarily create a text element above their head
	
