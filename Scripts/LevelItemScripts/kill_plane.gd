#Used for insta-kill effects for the player. Spikes, pits etc

extends Node2D

@export var current_scene_name:String

func _on_area_2d_body_entered(_body: Node2D) -> void:
	#We must defer the scene reload until the current frame finishes 
	#for physics objects
	if _body.name == 'Player':
		get_tree().change_scene_to_file.call_deferred("res://Levels/"+current_scene_name)
