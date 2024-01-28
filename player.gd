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
		if input_direction.x < 0:
			animation.play ("Walk Left")
	else:
		animation.play("Idle")

func _physics_process(_delta):
	get_input()
	move_and_slide()
