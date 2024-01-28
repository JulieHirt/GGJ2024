extends CharacterBody2D

@onready var animation = get_node("AnimatedSprite2D")

const speed = 300.0

func _ready():
	animation.play("Idle")

func get_input():
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = input_direction * speed
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
	get_input()
	move_and_slide()
