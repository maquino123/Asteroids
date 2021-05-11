extends TextureProgress

func _ready():
	pass
	
func _physics_process(delta):
	if(get_tree().get_root().get_node("Variant").get_node("Player2") != null):
		value = get_tree().get_root().get_node("Variant").get_node("Player2").hp
		
		
	
