#NOTE: CHECK "VISIBLE NAVIGATION" UNDER THE "DEBUG" MENU

#IN THE NAVIGATIONAGENT2D NODE, UNDER DEBUG, CHECK "ENABLED"
extends CharacterBody2D
@export var movement_speed: float = 200.0

@export var navigation_agent: NavigationAgent2D

var path_marker_index: int = 0 # the index of the path node that the agent is going towards

func _ready():
	# These values need to be adjusted for the actor's speed
	# and the navigation layout.
	#prevents jitering/hovering around the destinaion- this sets how close the agent needs to get to the target destination
	#before it thinks it is at the destination 
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0
	print("I AM THE ENEMY MAN")


	# Make sure to not await during _ready.
	call_deferred("actor_setup")

func actor_setup():
	#wait after the first frame for the navmesh to be set up
	await get_tree().physics_frame
	#print("guard nav mesh setup");
	
	# .position gets the position of movement_target which is a Vector2
	
func set_movement_target(target_point: Vector2):
	navigation_agent.target_position = target_point;

#func advanceToNextMarker():
	#print("reached marker. Going to next marker.")
	#if we have not reached the last node yet


func _physics_process(delta):
	if navigation_agent.is_navigation_finished():
		#return
		#we have reached the marker. Go towards the next marker in the list.
		#advanceToNextMarker()
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
	move_and_slide()
	move_and_collide(new_velocity)
	#the direction and speed are stored in the special godot variable "velocity"
	#collide()
	handleCollision()

	#guard follows set path
	
	#if it collides with player, play animation and go to game over screen
	
	#extra features, add if there is time
	#if it hears noise, go towards the source of the noise. then return to next path node
	#if it "sees" player, go towards player. if it loses sight of player, return to next path node
	
	


func handleCollision():
	for i in get_slide_collision_count():
		print("collision found")
		var collision = get_slide_collision(i)
		var collider =collision.get_collider()
		print_debug(collider.name)
		if(collider.name == "JuggleBall"):
			print("Win in guard prefab")
			get_node("..").Win()
			#get_tree().change_scene_to_file("res://game_over.tscn")

#Call this function when the target needs to die
func YourHonor():
	print("League of Legends")
	queue_free() #Death
	
#Call this function when the target is harassed by a nonlethal item
func Pranked():
	print("PRANKED")
	#TODO: figure out how we're actually going to have the target speak.
	#My default choice would be to temporarily create a text element above their head
	




func _on_area_2d_area_entered(area):
	print("Fuckery 1")


func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	print("Fuckery 2")



func _on_area_2d_body_entered(body):
	print("Fuckery 3")



func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	print("Fuckery 4")

