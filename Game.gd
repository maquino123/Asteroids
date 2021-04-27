extends Node2D

func _ready() -> void:
	connect("resized", self, "call_wrap_around")

func call_wrap_around():
	get_tree().call_group("wrap_around", "recalculate_wrap_area")


# game over
func _on_Player_player_died() -> void:
	# stop gameplay music and load game over music
	$MusicPlayer.stop()
	$MusicPlayer.stream = load("res://assets/audio/music/sawsquarenoise_-_06_-_Towel_Defence_Jingle_Loose.ogg")
	$MusicPlayer.stream.loop = false
	$MusicPlayer.volume_db = -5
	
	# stop new asteroids from spawning
	$Spawner/SpawnTimer.stop()
	
	# turn off "roaring" sound for asteroids that already exist
	for a in get_tree().get_nodes_in_group("asteroids"):
		a.get_node("AudioStreamPlayer2D").stop()
	
	$GameOverTimer.start()


func _on_GameOverTimer_timeout() -> void:
	# start game over music and display game over screen
	$MusicPlayer.play(0)
	$GameOverLabel.visible = true
