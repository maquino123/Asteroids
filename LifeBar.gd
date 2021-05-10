extends TextureProgress

func _ready():
	pass
	
func _physics_process(delta):
	if(get_tree().get_root().get_node("Variant").get_node("Player") != null):
		value = get_tree().get_root().get_node("Variant").get_node("Player").hp
	
