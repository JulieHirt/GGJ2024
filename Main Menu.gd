extends Node2D


func _on_start_game_pressed():
	get_tree().change_scene_to_file("res://level1.tscn")

func _on_quit_game_pressed():
	get_tree().quit()
