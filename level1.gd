extends Node2D

func Win():
	print("Win")
	#this code is janky
	#see https://github.com/godotengine/godot/issues/85251
	if(is_inside_tree()):
		get_tree().change_scene_to_file("res://win.tscn")
	else:
		print("error when attempting to load win scene")
	
func GameOver():
	print("Game Over")
	#this code is janky
	#see https://github.com/godotengine/godot/issues/85251
	if(is_inside_tree()):
		get_tree().change_scene_to_file("res://game_over.tscn")
	else:
		print("error when attempting to load game over scene")
