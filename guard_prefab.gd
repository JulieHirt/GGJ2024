#NOTE: CHECK "VISIBLE NAVIGATION" UNDER THE "DEBUG" MENU

#IN THE NAVIGATIONAGENT2D NODE, UNDER DEBUG, CHECK "ENABLED"
extends CharacterBody2D
@export var movement_speed: float = 200.0

@export var movement_target: Node2D
@export var navigation_agent: NavigationAgent2D

func _ready():
	# These values need to be adjusted for the actor's speed
	# and the navigation layout.
	#prevents jitering/hovering around the destinaion- this sets how close the agent needs to get to the target destination
	#before it thinks it is at the destination 
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0

	# Make sure to not await during _ready.
	call_deferred("actor_setup")

func actor_setup():
	#wait after the first frame for the navmesh to be set up
	await get_tree().physics_frame
	print("guard nav mesh setup");
	
	# .position gets the position of movement_target which is a Vector2
	set_movement_target(movement_target.position);
	
func set_movement_target(target_point: Vector2):
	navigation_agent.target_position = target_point;

func _physics_process(delta):
	if navigation_agent.is_navigation_finished():
		return
	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	
	#new_velocity gives a vector indicating the direction the agent will move
	var new_velocity: Vector2 = next_path_position - current_agent_position
	#To normalize a vector means to go in the same direction, but to only travel a distance of 1 unit
	new_velocity = new_velocity.normalized()
	new_velocity = new_velocity * movement_speed
	
	velocity = new_velocity
	#move_and_slide moves the agent based on its set direction and speed
	#the direction and speed are stored in the special godot variable "velocity"
	move_and_slide()
	

