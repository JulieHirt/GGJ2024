extends CharacterBody2D

@onready var animation = get_node("AnimatedSprite2D")

var anim_done = 0
var input_direction

const speed = 300.0

func _ready():
	animation.play("Idle")
	$HelloSFX.play()
	
func update_walk_anim():
	#set the correct animation based on the direction the player is facing
	if input_direction:
		if input_direction.x > 0:
			animation.play("Walk Right")
		if input_direction.y > 0:
			animation.play("Walk Down")
		if input_direction.x < 0:
			animation.play ("Walk Left")
		if input_direction.y < 0:
			animation.play("Walk Up")
	else:
		animation.play("Idle")
	#Hat Action is defined as the "E" Key on the keyboard
	if Input.is_action_just_pressed("Hat Action"):
		#animation.play("Hat") //we don't have this defined yet
		pass
	

func _physics_process(_delta):
	#get the directional key that the player is pressing to move
	input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	#set the velocity so that the player will move in correct direction
	velocity = input_direction * speed
	update_walk_anim()
	move_and_slide()
