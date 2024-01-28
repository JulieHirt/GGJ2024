extends Node

var startPos
var targetPos
var lethal: bool = false
var t = 0.0

var flipped = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.global_rotation = startPos.direction_to(targetPos).angle() + (3.15)
	
	var diffX = targetPos.x - startPos.x
	var diffY = targetPos.y - startPos.y
	var angle = atan(diffX / diffY)
	
	if startPos.y - targetPos.y < 0:
		$Sprite2D.global_position = startPos + Vector2(sin(angle) , cos(angle)) * 75
	else:
		$Sprite2D.global_position = startPos + Vector2(-1*sin(angle) , -1*cos(angle)) * 75


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	$Sprite2D.global_position = startPos.lerp(targetPos, t * 0.8)
	if !flipped:
		$Sprite2D.scale.x += 1.9 * delta
		t += 0.8 * delta
	else:
		$Sprite2D.scale.x -= 3.6 * delta
		t -= 1.6 * delta
	if t > 1:
		flipped = true
	if t < 0:
		queue_free()
