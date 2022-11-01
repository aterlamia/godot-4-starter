extends Control

var current_scene_index = 0;

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	get_node("/root/Events").on_scene_restarted(current_scene_index)
