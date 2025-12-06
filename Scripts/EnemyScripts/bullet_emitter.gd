extends Area2D

#Enemy bullet emitter type that moves across the screen and launches bullets

const ENEMY_BULLET = preload("res://Scenes/enemy_bullet.tscn")

@export var bullet_spawn:Marker2D
@export var bullet_parent_node: Node

var default_bullet_speed:float = 500.0
var default_bullet_direction: Vector2 = Vector2(0,1)

var burst_size_max:int = 7
var cooldown_max:float = 2.0
var fire_rate_max:float = 0.15

var burst_size:int = 7
var cooldown:float = 2.0
var fire_rate:float = 0.1

var emitter_movement_speed:float = 150.0
var emitter_movement_direction:Vector2 = Vector2 (1,0)
var emitter_change_direction_timer:float = 4.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	#move the emitter back and forth, TODO add new movement modes for enemy emitters
	position += emitter_movement_direction.normalized() * emitter_movement_speed * _delta
	emitter_change_direction_timer -= _delta
	if emitter_change_direction_timer <= 0:
		emitter_movement_direction = Vector2(emitter_movement_direction.x * -1, emitter_movement_direction.y)
		emitter_change_direction_timer = 4.0
	
	cooldown -= _delta
	fire_rate -= _delta
	if cooldown <= 0:
		if fire_rate <= 0:
			_fire_bullet()
			fire_rate = fire_rate_max
			burst_size -= 1
			if burst_size <=0:
				cooldown = cooldown_max
				burst_size = burst_size_max

		


func _fire_bullet() -> void:
	var new_bullet = ENEMY_BULLET.instantiate()
	new_bullet.position = position
	#new_bullet.set_speed(default_bullet_speed)
	#new_bullet.set_direction(default_bullet_direction)
	bullet_parent_node.add_child(new_bullet)
