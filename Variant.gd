extends Node2D

var game_over := false
var player_scene = load("res://Characters/Player2.tscn")

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
	$AsteroidSpawnerVar/SpawnTimerVar.stop()
	
	# turn off "roaring" sound for asteroids that already exist
	for a in get_tree().get_nodes_in_group("asteroids"):
		if(!a.is_queued_for_deletion() and a.has_node("AudioSteamPlayer2D")):
			a.get_node("AudioStreamPlayer2D").stop()
	
	$GameOverTimer.start()


func _on_GameOverTimer_timeout() -> void:
	# start game over music and display game over screen
	$MusicPlayer.play(0)
	$GameOverLabel.visible = true
	game_over = true


func _unhandled_key_input(event: InputEventKey) -> void:
	if (event.is_action_pressed("restart")):
		_restart_game()
	
func _restart_game():
	_undo_game_over()
	_respawn()
	$AsteroidSpawnerVar.restart()
	$GUI/MarginContainer/HBoxContainer/VBoxContainer/Score.reset()
	game_over = false
	

func _undo_game_over():
	$GameOverLabel.visible = false
	$MusicPlayer.stop()
	$MusicPlayer.stream = load("res://assets/audio/music/sawsquarenoise_-_03_-_Towel_Defence_Ingame.ogg")
	$MusicPlayer.stream.loop = true
	$MusicPlayer.volume_db = -20
	$MusicPlayer.play(0)

func _respawn():
	var player = player_scene.instance()
		
	player.position = Vector2(630, 680)
	add_child(player)

