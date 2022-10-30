extends Control

var current_scene_index = 0;

func _ready():
	pass

func _process(delta):
	pass

func _on_button_pressed():
	get_node("/root/Events").on_scene_restarted(current_scene_index)
