extends Node

var t = 2.2
var phase = 0

func _ready():
	$WhoYou.play()
	$TextEdit.text = "Huh? Who are you?"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if t <= 0:
		match phase:
			0:
				t = 2.5
				phase = 1
				$MyName.play()
				$TextEdit.text = "Hello, my name is Bubbles."
			1:
				t = 11.5
				phase = 2
				$HelloMister.play()
				$TextEdit.text = "Hello mister Bubbles. You have been assigned to assasinate the bad man, Mr. Man. Carry out this task or you will be terminated forever. Good luck. Have fun."
			2:
				get_tree().change_scene_to_file("res://level1.tscn")
	else:
		t -= 1 * delta
		
	
