extends Label
func _ready() -> void:
	get_node("/root/Events").fps_displayed.connect(_on_fps_displayed)
	

func _process(_delta: float) -> void:
	if(visible):
		text = "FPS: %s" % [Engine.get_frames_per_second()]
	
func _on_fps_displayed(value: bool) -> void:
	visible = value
