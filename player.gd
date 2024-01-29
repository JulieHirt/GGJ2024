extends CharacterBody2D

@onready var animation = get_node("AnimatedSprite2D")

var anim_done = 0
var input_direction

const speed = 300.0

func _ready():
	animation.play("Idle")
	$HelloSFX.play()
	
func update_walk_anim():
	input_direction = Input.get_vector("Left", "Right", "Up", "Down")
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
		if Input.is_action_just_pressed("Hat Action"):
			animation.stop()
			animation.play("Hat")
		else:
			animation.play("Idle")	

func _process(_delta):
	#########move the player############
	#get the directional key that the player is pressing to move
	input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	#set the velocity so that the player will move in correct direction
	velocity = input_direction * speed
	move_and_slide()
	#################play the correct animation##########
	
	#Hat Action is defined as the "E" Key on the keyboard
	if Input.is_action_just_pressed("Hat Action"):
		animation.stop()
		animation.play("Hat")
		anim_done = 0
	if anim_done == 1:
		update_walk_anim()
	#anim_done = 0



func _on_animated_sprite_2d_animation_finished():
	anim_done = 1
	#update_walk_anim()
	animation.play("Idle")
