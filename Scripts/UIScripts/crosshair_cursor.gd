extends Node2D

@export var player_node: Node2D = null

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _process(_delta):
	global_position = get_viewport().get_mouse_position()
 
