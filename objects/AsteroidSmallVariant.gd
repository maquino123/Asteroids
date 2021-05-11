extends "res://objects/AsteroidVariant.gd"

func _ready() -> void:
	var main_camera = get_node("/root/Variant/MainCamera")
	self.connect("explode", main_camera, "asteroid_small_exploded")
	#Smaller asteroids worth more
	score_value = 250
	
func explode():
	if exploded:
		return
	_explosion_particles()
	explosion_pitch = 1.4
	_play_explosion_sound()
	exploded = true 
	
	emit_signal("explode")
	
	emit_signal("score_changed", score_value)
	_spawn_score()
	
	get_parent().remove_child(self)
	queue_free()
