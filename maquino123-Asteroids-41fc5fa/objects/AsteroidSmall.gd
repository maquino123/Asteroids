extends "res://objects/Asteroid.gd"

func explode():
	if exploded:
		return
	exploded = true 
	
	get_parent().remove_child(self)
	queue_free()
