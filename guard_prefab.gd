#NOTE: CHECK "VISIBLE NAVIGATION" UNDER THE "DEBUG" MENU

#IN THE NAVIGATIONAGENT2D NODE, UNDER DEBUG, CHECK "ENABLED"
extends CharacterBody2D
@export var movement_speed: float = 200.0

@export var movement_target: Node2D
@export var navigation_agent: NavigationAgent2D
@export var marker_list: Node2D #markerlist is the list of markers that the guard will travel in between

var path_marker_index: int = 0 # the index of the path node that the agent is going towards

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

func advanceToNextMarker():
	print("reached marker. Going to next marker.")
	#if we have not reached the last node yet
	if(path_marker_index < marker_list.get_child_count()):
		#set the target position to the next marker in the list
		set_movement_target(marker_list.get_child(path_marker_index).position)
		path_marker_index = path_marker_index + 1
	#if we have reached the last node in the list
	else:
		path_marker_index = 0
		#reset the marer index so we go towards the first marker

func _physics_process(delta):
	if navigation_agent.is_navigation_finished():
		#return
		#we have reached the marker. Go towards the next marker in the list.
		advanceToNextMarker()
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
	handleCollision()

	#guard follows set path
	
	#if it collides with player, play animation and go to game over screen
	
	#extra features, add if there is time
	#if it hears noise, go towards the source of the noise. then return to next path node
	#if it "sees" player, go towards player. if it loses sight of player, return to next path node


func handleCollision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider =collision.get_collider()
		print_debug(collider.name)
		if(collider.name == "Player"):
			print("Game Over in guard prefab")
			get_node("..").GameOver()
			#get_tree().change_scene_to_file("res://game_over.tscn")
