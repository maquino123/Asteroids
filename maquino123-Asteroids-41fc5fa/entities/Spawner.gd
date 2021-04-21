extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var asteroid_scene = load("res://objects/Asteroid.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_spawn_asteroid() # Replace with function body.
	
func _spawn_asteroid():
	var asteroid = asteroid_scene.instance()
	_set_spawn_position(asteroid)
	
	add_child(asteroid)

func _set_spawn_position(asteroid):
	var viewboard= get_viewport().size
	asteroid.position = Vector2(rand_range(0, viewboard.x), -100)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _set_asteroid_speed(asteroid):
	asteroid.angular_velocity = rand_range(-4, 4)
	asteroid.angular_damp = 0
	asteroid.linear_velocity = Vector2(rand_range(-300, 300), -300)
	asteroid.linear_damp = 0

func _on_SpawnTimer_timeout():
	_spawn_asteroid()
	pass # Replace with function body.
