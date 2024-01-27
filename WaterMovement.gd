extends Node

var startPos
var targetPos
var lethal: bool = false

var t = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.global_position = startPos
	#TODO: rotate it properly


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	t += delta*0.8
	$Sprite2D.global_position = startPos.lerp(targetPos, t)
	if t >= 2:
		queue_free()
