extends Area2D

#Creates an area with a set number of ammunition reloads for player build terrain blocks

@onready var player = get_node("/root/Main/Player")

@export var quantity_available:int = 1

#adjusts how long they take to decay, and if they decay at all
#used for permanent reload areas as well as temporary
var decay_time:float = 10.0
var decaying: bool = false

func _physics_process(_delta: float) -> void:
	#remove if out of reloads to give player
	if quantity_available <= 0:
		queue_free()
	
	#remove is decay time reached
	if decaying:
		decay_time -= _delta
		if decay_time <= 0.0:
			queue_free()


func _on_area_2d_body_entered(_body: Node2D) -> void:
	#reload player ammunition if player needs ammo, only remove the quantity needed for full 
	#player reload
	if _body.name == "Player":
		var quantity_to_relaod = player.terrain_gun_ammo_max - player.terrain_gun_ammo
		if quantity_to_relaod > quantity_available:
			quantity_to_relaod = quantity_available
		player.add_terrain_gun_ammo(quantity_to_relaod)
		quantity_available -= quantity_to_relaod

#public functions to set reload time and reload quantity dynamically by source
func set_reload_quantity(_quantity:int) -> void:
	quantity_available = _quantity

func set_decay_time(_quantity:float) -> void:
	decay_time = _quantity
	decaying = true
