extends RigidBody2D

signal explode

var explosion_particles_scene := load("res://objects/ParticlesAsteroidExplosion.tscn")
var asteroid_small_scene := load("res://objects/AsteroidSmall.tscn")
var rng := RandomNumberGenerator.new()

var exploded := false
var explosion_pitch = 1

func _ready() -> void:
	var main_camera = get_node("/root/Game/MainCamera")
	self.connect("explode", main_camera, "asteroid_exploded")

func explode():
	if exploded:
		return
	exploded = true 
	
	_explosion_particles()
	_play_explosion_sound()
	
	emit_signal("explode")
	
	_spawn_asteroid_smalls(4)
	
	get_parent().remove_child(self)
	queue_free()

func _play_explosion_sound():
	var explosion_sound = AudioStreamPlayer2D.new()
	explosion_sound.stream = load("res://assets/audio/sfx/AsteroidExplosion.wav")
	explosion_sound.pitch_scale = explosion_pitch
	explosion_sound.position = self.position
	get_parent().add_child(explosion_sound)
	explosion_sound.play(0)
	
func _explosion_particles():
	var explosion_particles = explosion_particles_scene.instance()
	explosion_particles.position = self.position
	get_parent().add_child(explosion_particles)
	explosion_particles.emitting = true
	
func _spawn_asteroid_smalls(num: int):
	for i in range(num):
		_spawn_asteroid_small()
	
func _spawn_asteroid_small():
	var asteroid_small = asteroid_small_scene.instance()
	asteroid_small.position = self.position
	_randomize_trajectory(asteroid_small)
	get_parent().add_child(asteroid_small)
	
func _randomize_trajectory(asteroid):
	#Give the asteroids a random spin
	asteroid.angular_velocity = rand_range(-4, 4)
	asteroid.angular_damp = 0
	
	#Randomly choose -1, 0, or 1
	rng.randomize()
	var lv_x = rng.randi_range(-1, 1)
	var lv_y = rng.randi_range(-1, 1)
	
	#Random direction
	asteroid.linear_velocity = Vector2(lv_x * 400, lv_y * 400)
	asteroid.linear_damp = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()
