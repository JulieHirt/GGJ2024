extends Node

var randGen = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	var randNum: int = randGen.randf_range(1, 3);
	if randNum == 1:
		$AnotherSuccess.play()
	else:
		$Yay.play()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
