extends Node

@export var current_scene_index = 0
var current_scene:  Node = null

var log
func _ready():
	switch_to_scene(current_scene_index)
	#connect to the gameover signal on the global event
	log = get_node("/root/Log")
	get_node("/root/Events").scene_done.connect(_on_scene_done)
	get_node("/root/Events").gameover.connect(_on_game_over)
	get_node("/root/Events").scene_restarted.connect(_on_scene_restart)
	
	pass 


func _on_scene_restart(scene: int):
	switch_to_scene(scene )

func _on_scene_done(scene: int):
	switch_to_scene(scene + 1)

func _on_game_over(scene: int): 
	current_scene_index = -1

	set_current_scene("res://resources/scenes/ui/gameover_screen.tscn")
	current_scene.current_scene_index = scene

func switch_to_scene(scene: int): 
	current_scene_index = scene
	match scene:
		-1:
			set_current_scene("res://resources/scenes/ui/gameover_screen.tscn")
		0:
			set_current_scene("res://resources/scenes/ui/title_screen.tscn")	
		_:
			log.log_error("Scene index not found: " + str(scene), log.LogType.LOG_SCENE)

func set_current_scene(scene_path: String): 
	if (current_scene != null):
		remove_child(current_scene)
		current_scene.call_deferred("free")
	var next_level_resource = load(scene_path)
	var next_level = next_level_resource.instantiate()
	add_child(next_level)
	current_scene = next_level
	get_node("/root/Events").on_scene_started(current_scene_index)
	
