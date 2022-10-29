extends Node2D

var Logger := load("res://src/managers/log.gd")
@export_flags("LOG_ERROR","LOG_WARN", "LOG_INFO", "LOG_DEBUG") var log_level: int = Logger.LogSeverity.LOG_NONE
@export_flags("LOG_GENERAL","LOG_UI", "LOG_ENEMY", "LOG_PLAYER", "LOG_SIGNAL", "LOG_PATHFINDING", "LOG_INIT", "LOG_EXIT", "LOG_SCENE") var log_type: int = Logger.LogType.LOG_GENERAL

var log

func _ready():
	self.log = get_node("/root/Log")
	self.log.init(self.log_level, self.log_type)

	get_node("/root/Events").on_scene_done(1)
	get_node("/root/Events").on_scene_done(2)
	get_node("/root/Events").on_scene_done(3)
	
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
