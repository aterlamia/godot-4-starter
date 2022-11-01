extends Node

@export var current_scene_index = 0
var current_scene:  Node = null

var logger

func _ready() -> void:
	if current_scene_index >= 0:
		switch_to_scene(current_scene_index)
		
	logger = get_node("/root/Log")
	get_node("/root/Events").scene_done.connect(_on_scene_done)
	get_node("/root/Events").gameover.connect(_on_game_over)
	get_node("/root/Events").scene_restarted.connect(_on_scene_restart)
	
	pass 


func _on_scene_restart(scene: int) -> void:
	switch_to_scene(scene)

func _on_scene_done(scene: int) -> void:
	switch_to_scene(scene + 1)

func _on_game_over(scene: int) -> void: 
	current_scene_index = -1

	set_current_scene("res://resources/scenes/ui/gameover_screen.tscn")
	current_scene.current_scene_index = scene

func switch_to_scene(scene: int) -> void: 
	current_scene_index = scene
	match scene:
		-1:
			set_current_scene("res://resources/scenes/ui/gameover_screen.tscn")
		1:
			set_current_scene("res://resources/scenes/levels/TestScene.tscn")
		_:
			logger.log_error("Scene index not found: " + str(scene), logger.LogType.LOG_SCENE)
			return

	get_node("/root/Global").set_game_data(scene, "level")

func set_current_scene(scene_path: String) -> void: 
	if (current_scene != null):
		remove_child(current_scene)
		current_scene.call_deferred("free")
	var next_level_resource = load(scene_path)
	var next_level = next_level_resource.instantiate()
	add_child(next_level)
	current_scene = next_level
	current_scene.load()
	get_node("/root/Events").on_scene_started(current_scene_index)
	
