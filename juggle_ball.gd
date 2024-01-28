extends Area2D

var startPos
var realStartPos
var targetPos
var extraPos
var t = 0.0
var lethal: bool = true
var peaked: bool = false
var lean = 1 #0 is all the way towards the main target. 1 is all the way to the perpendicular point

var xNeg: bool
var yNeg: bool

func _ready():
	$Sprite2D.global_position = startPos

	
	#CALCULATE THE SECOND POSITION
	#The difference between the two normal points
	var diffX = targetPos.x - startPos.x
	var diffY = targetPos.y - startPos.y
	#If they're negative
	if diffX < 0:
		xNeg = true
	if diffY < 0:
		yNeg = true
	
	#Get the distance from eachother
	var distance = sqrt(pow(diffX,2) + pow(diffY,2))
	#Also get the angle
	var oldAngle = atan(diffX / diffY)
	
	#Get the new Y value
	var newY = distance * sin(oldAngle + 45)
	#Then the X
	var newX = sqrt(pow(diffX,2) + pow(diffY,2) - pow(newY,2))
	
	if xNeg:
		newX *= -1
	if yNeg:
		newY *= -1
	
	extraPos = Vector2(newX + startPos.x, newY + startPos.y)
	print("Extra pos is " + str(extraPos))
	
	pass # Replace with function body.
	
func _physics_process(delta):
	
	if extraPos != null:
		t += delta*0.8
		var actualTarget = Vector2(targetPos.x * (1-lean) + extraPos.x * lean, targetPos.y * (1-lean) + extraPos.y * lean)
		
		$Sprite2D.global_position = startPos.lerp(actualTarget, t)
		if lean > 0:
			lean -= delta*0.8
		
	if t >= 1:
		queue_free()

func _on_body_entered(body):
	if body.name == "GuardPrefab":
		queue_free()
	
	if body.name == "Target":
		print("The target is hit!")
		get_node("..").Win()
		queue_free()
		
