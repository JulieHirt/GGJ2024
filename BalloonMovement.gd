extends Node

var startPos
var targetPos
var lethal: bool = false
var t = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	var diffX = targetPos.x - startPos.x
	var diffY = targetPos.y - startPos.y
	var angle = atan(diffX / diffY)
	
	if startPos.y - targetPos.y < 0:
		$Sprite2D.global_position = startPos + Vector2(sin(angle) , cos(angle)) * 15
	else:
		$Sprite2D.global_position = startPos + Vector2(-1*sin(angle) , -1*cos(angle)) * 15
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	t += 0.2 * delta
	
	if t >= 1: 
		print("KABOOOOOMMMMM!!!!!")
		queue_free()
