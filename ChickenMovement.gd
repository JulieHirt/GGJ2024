extends Node

var startPos
var realStartPos
var targetPos
var t = 0.0
var lethal: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	#Look at where the mouse was
	$Sprite2D.look_at(targetPos)
	#Find the angle
	var diffX = targetPos.x - startPos.x
	var diffY = targetPos.y - startPos.y
	var angle = atan(diffX / diffY)
	
	if startPos.y - targetPos.y < 0:
		$Sprite2D.global_position = startPos + Vector2(sin(angle) , cos(angle)) * 75
	else:
		$Sprite2D.global_position = startPos + Vector2(-1*sin(angle) , -1*cos(angle)) * 75
	realStartPos = $Sprite2D.global_position
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Sprite2D.global_position = startPos + (realStartPos - startPos).rotated(1.5 * t) 
	$Sprite2D.rotation = 0 + (4 * t)
	t += 1.5 * delta
	
	if t >= 1:
		queue_free()
