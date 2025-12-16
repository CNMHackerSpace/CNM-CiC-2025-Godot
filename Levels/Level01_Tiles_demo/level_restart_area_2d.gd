# Level Restart Area Script
# Programmer: Rob Garner (rgarner7@cnm.edu)
# This script handles the restart area for the level.
extends Area2D

func _on_body_entered(body):
    '''Called when a body enters the restart area. If the body is the player, the scene is restarted.'''
    if body.name == "Player":
        call_deferred("_restart_scene")

func _restart_scene():
    '''Restarts the current scene. Called via call_deferred to avoid issues with changing scenes during physics processing.'''
    get_tree().reload_current_scene()
