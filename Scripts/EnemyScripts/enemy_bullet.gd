extends Area2D

#THIS SHOULD PROBABLY BE MOVED, TESTING ONLY
const RELOAD_OBJECT = preload("res://Scenes/reloader.tscn")

var speed:float = 500.0
var direction:Vector2 = Vector2(0,1)
var delete = false

func _ready() -> void:
	pass # Replace with function body.


func _physics_process(_delta: float) -> void:
	#move bullet in its specific direction, delete once it impacs a collider
	direction = direction.normalized()
	position += direction * speed * _delta
	if delete:
		queue_free()


func _on_body_entered(_body: Node2D) -> void:
	if _body.name == "Player":
		#damage player
		queue_free()
	
	#random chance to spawn an entropy puddle on colliding with terrain
	else: 
		var r = randi_range(1,10)
		#creates a new reloader with 1 ammo 1 in 10 shots
		if r == 10:
			#print("Spawning", global_position)
			var new_reloader = RELOAD_OBJECT.instantiate()
			new_reloader.global_position = global_position
			new_reloader.set_reload_quantity(1)
			new_reloader.set_decay_time(6.0)
			get_parent().call_deferred("add_child", new_reloader)

	delete = true	

		


#allows setting variables from emitter
func set_speed(_speed:int) ->void:
	speed = _speed

func set_direction(_direction:Vector2)-> void:
	direction = _direction